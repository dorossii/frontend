import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {

  final VoidCallback onLogoutPressed;

  const SettingsView({
    super.key,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('ログアウト'),

          onTap: onLogoutPressed,
        ),
      ],
    );
  }
}