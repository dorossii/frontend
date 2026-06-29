// Flutterのマテリアルデザインウィジェットを使用するためのインポート
import 'package:flutter/material.dart';
// LiveKitクライアントSDKから参加者・トラック関連のクラスをインポート
import 'package:livekit_client/livekit_client.dart';

// 各参加者を表示するタイルウィジェット（StatefulWidget）
class ParticipantTile extends StatefulWidget {
  // 表示対象の参加者オブジェクト
  final Participant participant;
  // ローカル（自分自身）かどうかを示すフラグ（デフォルトはfalse）
  final bool isLocal;

  // コンストラクタ：participantは必須、isLocalは省略可能
  const ParticipantTile({
    super.key,
    required this.participant,
    this.isLocal = false,
  });

  // 対応するStateクラスを生成する
  @override
  State<ParticipantTile> createState() => _ParticipantTileState();
}

// ParticipantTileの状態管理クラス
class _ParticipantTileState extends State<ParticipantTile> {
  // 現在表示中のビデオトラック（映像がない場合はnull）
  VideoTrack? _videoTrack;
  // ビデオが有効（送信中かつミュートされていない）かどうか
  bool _videoEnabled = false;
  // オーディオが有効（ミュートされていない）かどうか
  bool _audioEnabled = false;

  @override
  void initState() {
    super.initState();
    // 初期化時にトラック情報を取得する
    _updateTracks();
    // 参加者の状態変化（トラック追加・削除・ミュートなど）を監視するリスナーを登録する
    widget.participant.addListener(_onParticipantChanged);
  }

  @override
  void dispose() {
    // ウィジェット破棄時にリスナーを解除してメモリリークを防ぐ
    widget.participant.removeListener(_onParticipantChanged);
    super.dispose();
  }

  // 参加者の状態が変化したときに呼ばれるコールバック
  void _onParticipantChanged() {
    // ウィジェットがまだ画面に存在する場合のみトラック情報を更新する
    if (mounted) {
      _updateTracks();
    }
  }

  // 参加者のトラック一覧を走査してビデオ・オーディオの状態を更新するメソッド
  void _updateTracks() {
    // 取得したビデオトラックを一時的に保持する変数
    VideoTrack? videoTrack;
    // ビデオ有効フラグの一時変数
    bool videoEnabled = false;
    // オーディオ有効フラグの一時変数
    bool audioEnabled = false;

    // 参加者が持つすべてのトラックパブリケーションをループ処理する
    for (final pub in widget.participant.trackPublications.values) {
      // ビデオトラックであり、トラックが存在し、サブスクライブ済みで、ミュートされていない場合
      if (pub.kind == TrackType.VIDEO &&
          pub.track != null &&
          pub.subscribed &&
          !pub.muted) {
        // VideoTrackとしてキャストして保持する
        videoTrack = pub.track as VideoTrack;
        // ビデオを有効状態にする
        videoEnabled = true;
      }
      // オーディオトラックであり、ミュートされていない場合
      if (pub.kind == TrackType.AUDIO && !pub.muted) {
        // オーディオを有効状態にする
        audioEnabled = true;
      }
    }

    // setStateでUIを再描画し、最新のトラック状態を反映する
    setState(() {
      _videoTrack = videoTrack;
      _videoEnabled = videoEnabled;
      _audioEnabled = audioEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 参加者名が空の場合は「匿名」を使用する
    final name =
        widget.participant.name.isNotEmpty ? widget.participant.name : '匿名';
    // ローカル参加者の場合は名前の後ろに「(自分)」を付加する
    final displayName = widget.isLocal ? '$name (自分)' : name;

    // タイル全体のコンテナ（角丸・背景色付き）
    return Container(
      decoration: BoxDecoration(
        // 濃紺の背景色（ビデオなし時の背景として使用）
        color: const Color(0xFF0F3460),
        // 角を12pxの半径で丸める
        borderRadius: BorderRadius.circular(12),
      ),
      // 子ウィジェットが角丸の外にはみ出さないようにクリップする
      clipBehavior: Clip.hardEdge,
      child: Stack(
        // Stackの子ウィジェットを親のサイズいっぱいに広げる
        fit: StackFit.expand,
        children: [
          // ビデオが有効でトラックが存在する場合はビデオ映像を表示する
          if (_videoEnabled && _videoTrack != null)
            VideoTrackRenderer(_videoTrack!)
          else
            // ビデオがない場合は中央にアバターアイコンを表示する
            Center(
              child: CircleAvatar(
                // アバターの半径
                radius: 32,
                // アバターの背景色（紫系）
                backgroundColor: const Color(0xFF6C63FF),
                child: Text(
                  // 名前の頭文字を大文字で表示、名前が空なら「?」を表示
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    // 文字サイズ28px
                    fontSize: 28,
                    // 文字色は白
                    color: Colors.white,
                    // 太字で表示
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          // 名前バー（タイル下部に絶対配置で表示）
          Positioned(
            // 下から8pxの位置に配置
            bottom: 8,
            // 左端から8px内側に配置
            left: 8,
            // 右端から8px内側に配置
            right: 8,
            child: Container(
              // 横8px・縦4pxのパディングを設定する
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                // 半透明の黒背景（名前を読みやすくするため）
                color: Colors.black54,
                // 角を6pxの半径で丸める
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                // Rowが内容に合わせた最小サイズになるようにする
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 名前テキストを残りのスペースいっぱいに広げる
                  Expanded(
                    child: Text(
                      // 表示用の名前（自分の場合は「(自分)」付き）
                      displayName,
                      style: const TextStyle(
                          // 文字色は白、サイズは12px
                          color: Colors.white, fontSize: 12),
                      // 名前が長い場合は末尾を「...」で省略する
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // オーディオが無効（ミュート中）の場合はミュートアイコンを表示する
                  if (!_audioEnabled)
                    const Icon(Icons.mic_off,
                        // アイコン色は赤系、サイズは14px
                        color: Colors.redAccent, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
