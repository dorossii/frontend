// Flutterのマテリアルデザインウィジェットをインポートする
import 'package:flutter/material.dart';

import '../Colors.dart';

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
      color: AppColors.background,
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
            color:micEnabled ? AppColors.subBackground : Colors.redAccent, // アイコン色
            backgroundColor: AppColors.background, // 背景色
            textStyle: TextStyle(
              color:micEnabled ? AppColors.subBackground : Colors.redAccent,
              fontFamily: 'textFont',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            onTap: onToggleMic,
          ),
          // 通話終了ボタン：大きめのサイズ・赤背景で目立たせる
          _ControlButton(
            icon: Icons.call_end,
            label: '終了',
            color: AppColors.subBackground,
            // 終了ボタンのみ赤背景にする
            backgroundColor: Colors.red,
            textStyle: const TextStyle(
              color: AppColors.subBackground,
              fontFamily: 'textFont',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            onTap: onLeave,
            // 他のボタンより大きく表示する
            large: true,
          ),
          // カメラボタン：オン状態はビデオカメラアイコン・白色、オフ状態はバツ付きアイコン・赤色
          _ControlButton(
            icon: cameraEnabled ? Icons.videocam : Icons.videocam_off,
            label: cameraEnabled ? 'カメラOFF' : 'カメラON',
            color:cameraEnabled ? AppColors.subBackground : Colors.redAccent, // アイコン色
            backgroundColor: AppColors.background, // 背景色
            textStyle: TextStyle(
              color:cameraEnabled ? AppColors.subBackground : Colors.redAccent,
              fontFamily: 'textFont',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            onTap: onToggleCamera,
          ),
        ],
      ),
    );
  }
}

// コントロールバー内の個々のボタンウィジェット（アイコン＋ラベルの縦並び）
class _ControlButton extends StatelessWidget {
  /// アイコン
  final IconData icon;

  /// ラベル
  final String label;

  /// アイコン色
  final Color color;

  /// 背景色
  final Color backgroundColor;

  /// ラベルの文字スタイル
  final TextStyle? textStyle;

  /// タップ時
  final VoidCallback onTap;

  /// 終了ボタンだけ大きくする
  final bool large;

  const _ControlButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.backgroundColor = const Color(0xFF0F3460),
    this.textStyle,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: large ? 38 : 24,
            backgroundColor: backgroundColor,
            child: Icon(icon, color: color, size: large ? 34 : 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style:
                textStyle ??
                const TextStyle(color: AppColors.subBackground, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
