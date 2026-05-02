import 'package:flutter/material.dart';

// login画面のUI

class LoginView extends StatelessWidget {
  final bool isLoading;                 // ローディング状態
  final VoidCallback onLoginPressed;    // ボタン押下時の処理

  const LoginView({
    super.key,
    required this.isLoading,
    required this.onLoginPressed,
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ログインボタン
          SizedBox(
            width: 200, 
            height: 56,
            child: ElevatedButton(
              onPressed: isLoading ? null : onLoginPressed,

              child: isLoading
                  // ロード中
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  // 通常
                  : const Text('ログイン'),
            ),
          ),
          // ロード中の説明
          if (isLoading) ...[
            const SizedBox(height: 24),
            const Text('ブラウザでログインを完了してください'),
          ],
        ],
      ),

    );
  }
}