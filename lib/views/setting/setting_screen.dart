import 'package:flutter/material.dart';

import 'setting_view.dart';

class SettingScreen extends StatelessWidget {

  final Future<void> Function() onLogoutPressed;

  const SettingScreen({
    super.key,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('設定'),
      ),

      body: SettingsView(

        onLogoutPressed: () async {

          // 確認ダイアログ
          final result = await showDialog<bool>(
              context: context,

              builder: (dialogContext) => AlertDialog(

                title: const Text('ログアウト'),

                content: const Text(
                  'ログアウトしますか？',
                ),

                actions: [

                  TextButton(
                    onPressed: () {

                      // dialog閉じる
                      Navigator.pop(dialogContext, false);
                    },
                    child: const Text('キャンセル'),
                  ),

                  ElevatedButton(
                    onPressed: () {

                      // dialog閉じる
                      Navigator.pop(dialogContext, true);
                    },
                    child: const Text('ログアウト'),
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