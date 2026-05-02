import 'package:flutter/material.dart';
import 'login_view.dart';
import 'login_viewmodel.dart';
import '/screens/browser_launched_screen.dart';

// login画面の制御と状態管理
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = LoginViewModel();

  /// ボタン押されたとき
  Future<void> _handleLogin() async {
    setState(() {}); // UI更新（loading反映）

    final success = await viewModel.login();

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const BrowserLaunchedScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ログインに失敗しました')),
      );
    }

    setState(() {}); // loading解除反映
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginView(
        isLoading: viewModel.isLoading,
        onLoginPressed: _handleLogin,
      ),
    );
  }
}