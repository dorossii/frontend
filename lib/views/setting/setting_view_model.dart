import 'package:flutter/material.dart';

import '../../services/auth_manager.dart';
import '../login/login_screen.dart';

class SettingsViewModel {

  /// ログアウト
  Future<void> logout(BuildContext context) async {

    // 保存トークン削除
    await AuthManager.logout();

    if (!context.mounted) return;

    // Login画面へ
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (_) => false,
    );
  }
}