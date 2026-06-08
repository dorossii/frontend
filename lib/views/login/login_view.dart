import 'package:flutter/material.dart';
import '../../components/colors.dart';

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
    // 箒のサイズ
    final broomWidth = MediaQuery.of(context).size.width * 1.2;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 上部の箒 (赤) 
          Positioned(
            top: -120, // 画面の上からはみ出させる
            left: -100, // 画面の左からはみ出させる
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(0 / 360), 
              child: Image.asset(
                'images/broom1.png', 
                width: broomWidth,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // 下部の箒 (青) 
          Positioned(
            bottom: -150, // 画面の下からはみ出させる
            right: -150, // 画面の右からはみ出させる
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(0 / 360), 
              child: Image.asset(
                'images/broom2.png',
                width: broomWidth,
                fit: BoxFit.contain,
              ),
            ),
          ),
            SafeArea(
            child: Container(
              width: double.infinity, 
              height: double.infinity, 
              // UI要素を箒の上に配置するためにClipBehavior.antiAliasを指定
              clipBehavior: Clip.antiAlias, 
              decoration: BoxDecoration(), 
              child: SingleChildScrollView( 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150), // 上部の箒と被りすぎないように調整

                    // 中央のロゴ
                    Image.asset(
                      'images/logo.png', 
                      width: 170,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),

                    // タイトル
                    GradientText(
                        'DOROSSII',
                        gradient: AppColors.goldGradient,
                        style: const TextStyle(
                          fontFamily: 'LogoFont',
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(offset: Offset(0, 3), blurRadius: 5, color: Colors.black26),
                          ],
                        ),
                    ),
                     const SizedBox(height: 270), 
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                children: [
                  // ボタン
                  SizedBox(
                          width: 200, 
                          height: 56,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : onLoginPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.btnBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          child: isLoading
                              // ロード中
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.background),
                                  ),
                                )
                              // ログイン
                              : const Text(
                                  'ログイン',
                                  style: TextStyle(
                                    fontFamily: 'TextFont',
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      // 墓石
                      Positioned(
                        top: -65, 
                        right: -5, 
                        child: Image.asset(
                          'images/grave.png', 
                          width: 70, 
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  
                  // ロード中の説明テキスト
                  if (isLoading) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'ブラウザでログインを完了してください',
                      style: TextStyle(fontFamily: 'TextFont', color: Colors.white, fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ]
      ),
    );
  }
  }