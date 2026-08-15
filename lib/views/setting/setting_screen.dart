import 'package:flutter/material.dart';

import '../../components/Colors.dart';
import 'setting_view.dart';

class SettingScreen extends StatelessWidget {
  final Future<void> Function() onLogoutPressed;

  const SettingScreen({super.key, required this.onLogoutPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.subWhiteBackground,
      body: SettingsView(
        onLogoutPressed: () async {
          // 確認ダイアログ
          final result = await showDialog<bool>(
            context: context,

            builder: (dialogContext) => AlertDialog(
              backgroundColor: AppColors.subWhiteBackground,
              title: const Text(
                'ログアウトしますか？',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'textFont',
                  color: AppColors.text,
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    // dialog閉じる
                    Navigator.pop(dialogContext, false);
                  },
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'textFont',
                      color: AppColors.text,
                    ),
                  ),
                ),

                ElevatedButton(
                  style: OutlinedButton.styleFrom(
    backgroundColor: AppColors.subBackground, // 文字・アイコンの色
  side: BorderSide(color: AppColors.edgew), // 枠線の色
  ),
                  onPressed: () {
                    // dialog閉じる
                    Navigator.pop(dialogContext, true);
                  },
                  child: const Text(
                    'ログアウト',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'textFont',
                      color: AppColors.text,
                    ),
                  ),
                ),
              ],
            ),
          );

          // 押された
          if (result == true) {
            await onLogoutPressed();
          }
        },
      ),
    );
  }
}
