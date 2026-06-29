// デバッグログ出力のために dart:developer をインポートする（dev.log でログを出力）
import 'dart:developer' as dev;
// Flutterのマテリアルデザインウィジェットをインポートする
import 'package:flutter/material.dart';
// LiveKit クライアント SDK をインポートする（Room・イベント・トラック操作に使用）
import 'package:livekit_client/livekit_client.dart';
// LiveKit サーバーのURL・APIキー等の設定値をインポートする
import '/config/livekit_config.dart';
// JWT アクセストークンを生成するサービスをインポートする
import '/services/token_service.dart';
// 画面下部のコントロールバーウィジェットをインポートする
import '/components/widgets/control_bar.dart';
// 各参加者を表示するタイルウィジェットをインポートする
import '/components/widgets/participant_tile.dart';

// ビデオ通話中の画面ウィジェット（ルーム接続・参加者表示・操作ボタンを管理）
class CallScreen extends StatefulWidget {
  // 接続するルームの名前
  final String roomName;
  // このクライアントの表示名
  final String participantName;

  // コンストラクタ：両フィールドとも必須
  const CallScreen({
    super.key,
    required this.roomName,
    required this.participantName,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

// CallScreen の状態管理クラス
class _CallScreenState extends State<CallScreen> {
  // LiveKit のルームオブジェクト（接続後にセットされる）
  Room? _room;
  // ルームイベント（参加・退出・トラック変化等）を受け取るリスナー
  EventsListener<RoomEvent>? _listener;
  // 接続処理中かどうかのフラグ（true の間はローディング画面を表示）
  bool _connecting = true;
  // 接続エラー時のメッセージ（エラーなしの場合は null）
  String? _error;
  // マイクの有効状態（true = オン、false = ミュート）
  bool _micEnabled = true;
  // カメラの有効状態（true = オン、false = オフ）
  bool _cameraEnabled = true;
  // 現在ルームに存在する参加者の一覧（ローカル参加者を先頭に含む）
  List<Participant> _participants = [];

  @override
  void initState() {
    super.initState();
    // 画面表示と同時にルームへの接続処理を開始する
    _connect();
  }

  @override
  void dispose() {
    // ウィジェット破棄時にイベントリスナーを解放する
    _listener?.dispose();
    // ルームから切断する（まだ接続中の場合）
    _room?.disconnect();
    // ルームオブジェクトを破棄してリソースを解放する
    _room?.dispose();
    super.dispose();
  }

  // LiveKit サーバーへ接続する非同期メソッド
  Future<void> _connect() async {
    try {
      // TokenService を使って JWT アクセストークンを生成する
      final token = TokenService.generate(
        roomName: widget.roomName,
        participantName: widget.participantName,
      );

      // RoomOptions を指定して Room インスタンスを生成する
      final room = Room(
        roomOptions: const RoomOptions(
          // ネットワーク帯域に応じてビデオ品質を自動調整する
          adaptiveStream: true,
          // 視聴者がいないトラックの送信を自動停止して帯域を節約する
          dynacast: true,
        ),
      );
      // ルームのイベントを受け取るリスナーを生成する
      _listener = room.createListener();

      // 各種ルームイベントのハンドラーをチェーンで登録する
      _listener!
        // ルームへの接続が完了したときの処理
        ..on<RoomConnectedEvent>((event) {
          dev.log('[LK] RoomConnectedEvent');
          if (mounted) {
            setState(() {
              // ローディング画面を非表示にする
              _connecting = false;
              // 参加者リストを最新状態に更新する
              _updateParticipants(room);
            });
          }
        })
        // ルームから切断されたときの処理（通常終了・エラー両方）
        ..on<RoomDisconnectedEvent>((event) {
          dev.log('[LK] RoomDisconnectedEvent: ${event.reason}');
          // 前の画面（JoinScreen）に戻る
          if (mounted) Navigator.of(context).pop();
        })
        // 他の参加者がルームに参加したときの処理
        ..on<ParticipantConnectedEvent>((event) {
          dev.log('[LK] ParticipantConnectedEvent: ${event.participant.identity}');
          // 参加者リストを再構築して画面を更新する
          if (mounted) setState(() => _updateParticipants(room));
        })
        // 他の参加者がルームから退出したときの処理
        ..on<ParticipantDisconnectedEvent>((event) {
          dev.log('[LK] ParticipantDisconnectedEvent: ${event.participant.identity}');
          // 参加者リストを再構築して画面を更新する
          if (mounted) setState(() => _updateParticipants(room));
        })
        // 他の参加者のトラック（音声・映像）のサブスクライブが完了したときの処理
        ..on<TrackSubscribedEvent>((event) {
          dev.log('[LK] TrackSubscribedEvent');
          // 映像表示を更新するために参加者リストを再構築する
          if (mounted) setState(() => _updateParticipants(room));
        })
        // 他の参加者のトラックのサブスクライブが解除されたときの処理
        ..on<TrackUnsubscribedEvent>((event) {
          dev.log('[LK] TrackUnsubscribedEvent');
          // 映像表示を更新するために参加者リストを再構築する
          if (mounted) setState(() => _updateParticipants(room));
        })
        // 誰かのトラックがミュートされたときの処理（マイク・カメラOFF）
        ..on<TrackMutedEvent>((event) {
          if (mounted) setState(() => _updateParticipants(room));
        })
        // 誰かのトラックのミュートが解除されたときの処理
        ..on<TrackUnmutedEvent>((event) {
          if (mounted) setState(() => _updateParticipants(room));
        });

      // LiveKit サーバーへ接続する。マイク・カメラは起動時の状態で即時有効化する
      await room.connect(
        // 接続先サーバーの URL
        LiveKitConfig.serverUrl,
        // 認証用 JWT トークン
        token,
        // 接続と同時にマイク・カメラを有効化するオプション
        fastConnectOptions: FastConnectOptions(
          microphone: TrackOption(enabled: _micEnabled),
          camera: TrackOption(enabled: _cameraEnabled),
        ),
      );

      // 接続成功後にルームオブジェクトをフィールドに保持する
      _room = room;
    } catch (e) {
      dev.log('[LK] connect error: $e');
      if (mounted) {
        setState(() {
          // ローディング画面を非表示にする
          _connecting = false;
          // エラーメッセージをセットして画面にエラー表示する
          _error = e.toString();
        });
      }
    }
  }

  // ルームの現在の参加者リストをローカル参加者を先頭にして再構築するメソッド
  void _updateParticipants(Room room) {
    _participants = [
      // ローカル参加者（自分自身）を最初に追加する
      room.localParticipant!,
      // リモート参加者（他のユーザー）を後ろに追加する
      ...room.remoteParticipants.values,
    ];
  }

  // マイクのオン/オフを切り替える非同期メソッド
  Future<void> _toggleMic() async {
    // ローカル参加者オブジェクトを取得する（未接続の場合は何もしない）
    final local = _room?.localParticipant;
    if (local == null) return;
    // 現在の状態を反転させてマイクを切り替える
    await local.setMicrophoneEnabled(!_micEnabled);
    // UIを更新するために状態を反転する
    if (mounted) setState(() => _micEnabled = !_micEnabled);
  }

  // カメラのオン/オフを切り替える非同期メソッド
  Future<void> _toggleCamera() async {
    // ローカル参加者オブジェクトを取得する（未接続の場合は何もしない）
    final local = _room?.localParticipant;
    if (local == null) return;
    // 現在の状態を反転させてカメラを切り替える
    await local.setCameraEnabled(!_cameraEnabled);
    // UIを更新するために状態を反転する
    if (mounted) setState(() => _cameraEnabled = !_cameraEnabled);
  }

  // 「終了」ボタン押下時にルームから切断して前の画面に戻るメソッド
  Future<void> _leave() async {
    // ルームから切断する（サーバーに退出を通知する）
    await _room?.disconnect();
    // 前の画面（JoinScreen）に戻る
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // 接続処理中はローディング画面を表示する
    if (_connecting) {
      return const Scaffold(
        // 暗い背景色
        backgroundColor: Color(0xFF1A1A2E),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 紫色のローディングインジケーター
              CircularProgressIndicator(color: Color(0xFF6C63FF)),
              SizedBox(height: 20),
              // 接続中メッセージ
              Text('接続中...',
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
        ),
      );
    }

    // 接続エラーが発生した場合はエラー画面を表示する
    if (_error != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1A1A2E),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // エラーを示す赤いアイコン
                const Icon(Icons.error_outline,
                    color: Colors.redAccent, size: 64),
                const SizedBox(height: 16),
                // エラータイトルテキスト
                const Text('接続に失敗しました',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                // エラーの詳細メッセージ（ユーザーがコピーできるように SelectableText を使用）
                SelectableText(_error!,
                    style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        height: 1.5),
                    textAlign: TextAlign.center),
                const SizedBox(height: 24),
                // 前の画面に戻るボタン
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('戻る'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 通常の通話画面を表示する
    return Scaffold(
      // 暗い背景色（ビデオ通話に適した暗めのトーン）
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            // 参加者タイル表示エリア（残りの縦スペースをすべて使う）
            Expanded(
              child: _participants.isEmpty
                  // 参加者がいない場合（接続直後など）は待機メッセージを表示する
                  ? const Center(
                      child: Text('他の参加者を待っています...',
                          style: TextStyle(color: Colors.white54)),
                    )
                  // 参加者が自分1人の場合は中央に大きく表示する
                  : _participants.length == 1
                      ? Center(
                          child: SizedBox(
                            // 幅・高さ240pxの正方形タイルで表示する
                            width: 240,
                            height: 240,
                            child: ParticipantTile(
                              participant: _participants[0],
                              // 1人目はローカル参加者（自分自身）なので isLocal=true
                              isLocal: true,
                            ),
                          ),
                        )
                      // 参加者が2人以上の場合はグリッドレイアウトで表示する
                      : GridView.builder(
                          // グリッド全体に8pxのパディングを設定する
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            // 横に2列並べる
                            crossAxisCount: 2,
                            // タイル間の縦方向の隙間
                            mainAxisSpacing: 8,
                            // タイル間の横方向の隙間
                            crossAxisSpacing: 8,
                          ),
                          // 表示する参加者の総数
                          itemCount: _participants.length,
                          // 各インデックスに対応する参加者タイルを生成する
                          itemBuilder: (context, index) {
                            final p = _participants[index];
                            return ParticipantTile(
                              participant: p,
                              // ルームのローカル参加者と一致する場合は自分自身として扱う
                              isLocal: p == _room?.localParticipant,
                            );
                          },
                        ),
            ),
            // 画面下部のコントロールバー（マイク・カメラ・終了ボタン）
            ControlBar(
              // マイクの現在の状態を渡す
              micEnabled: _micEnabled,
              // カメラの現在の状態を渡す
              cameraEnabled: _cameraEnabled,
              // マイクトグルのコールバックを渡す
              onToggleMic: _toggleMic,
              // カメラトグルのコールバックを渡す
              onToggleCamera: _toggleCamera,
              // 通話終了のコールバックを渡す
              onLeave: _leave,
            ),
          ],
        ),
      ),
    );
  }
}
