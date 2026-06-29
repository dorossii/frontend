// Flutterのマテリアルデザインウィジェットをインポートする
import 'package:flutter/material.dart';

// 通話画面下部に表示するコントロールバーウィジェット（マイク・終了・カメラボタンを含む）
class ControlBar extends StatelessWidget {
  // マイクの有効状態（true = オン、false = ミュート）
  final bool micEnabled;
  // カメラの有効状態（true = オン、false = オフ）
  final bool cameraEnabled;
  // マイクボタンが押されたときのコールバック
  final VoidCallback onToggleMic;
  // カメラボタンが押されたときのコールバック
  final VoidCallback onToggleCamera;
  // 通話終了ボタンが押されたときのコールバック
  final VoidCallback onLeave;

  // 全フィールドが必須引数のコンストラクタ
  const ControlBar({
    super.key,
    required this.micEnabled,
    required this.cameraEnabled,
    required this.onToggleMic,
    required this.onToggleCamera,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    // コントロールバー全体のコンテナ（背景色・縦パディング設定）
    return Container(
      // 背景色を暗い紺色に設定する
      color: const Color(0xFF16213E),
      // 上下に16pxのパディングを設定する
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        // ボタンを均等間隔で横並びに配置する
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // マイクボタン：オン状態はマイクアイコン・白色、オフ状態はミュートアイコン・赤色
          _ControlButton(
            icon: micEnabled ? Icons.mic : Icons.mic_off,
            label: micEnabled ? 'ミュート' : 'ミュート解除',
            color: micEnabled ? Colors.white : Colors.redAccent,
            onTap: onToggleMic,
          ),
          // 通話終了ボタン：大きめのサイズ・赤背景で目立たせる
          _ControlButton(
            icon: Icons.call_end,
            label: '終了',
            color: Colors.white,
            // 終了ボタンのみ赤背景にする
            backgroundColor: Colors.red,
            onTap: onLeave,
            // 他のボタンより大きく表示する
            large: true,
          ),
          // カメラボタン：オン状態はビデオカメラアイコン・白色、オフ状態はバツ付きアイコン・赤色
          _ControlButton(
            icon: cameraEnabled ? Icons.videocam : Icons.videocam_off,
            label: cameraEnabled ? 'カメラOFF' : 'カメラON',
            color: cameraEnabled ? Colors.white : Colors.redAccent,
            onTap: onToggleCamera,
          ),
        ],
      ),
    );
  }
}

// コントロールバー内の個々のボタンウィジェット（アイコン＋ラベルの縦並び）
class _ControlButton extends StatelessWidget {
  // ボタンに表示するアイコン
  final IconData icon;
  // アイコン下部に表示するラベルテキスト
  final String label;
  // アイコンの色
  final Color color;
  // アイコンの背景色（デフォルトは濃紺）
  final Color backgroundColor;
  // ボタンタップ時のコールバック
  final VoidCallback onTap;
  // 大きいサイズで表示するかどうか（終了ボタン用）
  final bool large;

  // コンストラクタ：backgroundColorとlargeはオプション（デフォルト値あり）
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    // デフォルト背景色は濃紺
    this.backgroundColor = const Color(0xFF0F3460),
    // デフォルトは通常サイズ
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector でタップイベントを検知する
    return GestureDetector(
      onTap: onTap,
      child: Column(
        // Columnが内容に合わせた最小サイズになるようにする
        mainAxisSize: MainAxisSize.min,
        children: [
          // 円形のアイコンボタン（large の場合は半径30、通常は24）
          CircleAvatar(
            radius: large ? 30 : 24,
            backgroundColor: backgroundColor,
            // アイコンのサイズも large に応じて切り替える
            child: Icon(icon, color: color, size: large ? 28 : 22),
          ),
          // アイコンとラベルの間のスペース
          const SizedBox(height: 4),
          // ボタンのラベルテキスト（薄い白・小さめフォント）
          Text(label,
              style:
                  const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }
}
