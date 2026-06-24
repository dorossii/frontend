import 'package:flutter/material.dart';
import '../splash/task/splash_screen.dart';

class SettingsView extends StatelessWidget {
  final VoidCallback onLogoutPressed;

  const SettingsView({super.key, required this.onLogoutPressed});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('ログアウト'),

          onTap: onLogoutPressed,
        ),
        ElevatedButton(
          child: Text("タスクスプラッシュのテスト"),
          onPressed: () {
            // ここにボタンを押した時に呼ばれるコードを書く
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          },
        ),
      ],
    );
  }
}
