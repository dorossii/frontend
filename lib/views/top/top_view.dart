import 'package:authbase_mobile/components/Colors.dart';
import 'package:flutter/material.dart';
import 'top_view_model.dart';

class TopView extends StatelessWidget {
  final TopViewModel viewModel;

  const TopView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景画像 
          Positioned.fill(
            child: Image.asset(
              'images/home1.webp',
              fit: BoxFit.cover,
            ),
          ),

          // キャラクター画像 
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 180), // 下部パネルとの位置調整
              child: Image.asset(
                'images/character.png',
                height: 320,
                fit: BoxFit.contain,
              ),
            ),
          ),


          // ステータスとレスキューボタンのパネル
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border(top: BorderSide(color: const Color(0xFFB2D3D2), width: 2)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // コンテンツに合わせる
                  children: [
                    // 左側：ステータス
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildStatusBox("汚さレベル", "ちょー汚すぎうける"),
                          const SizedBox(height: 10),
                          _buildStatusBox("HP", "30/100"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // 右側：レスキューボタン
                    _buildRescueButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ステータスボックスのパーツ
  Widget _buildStatusBox(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ],
    );
  }

  // レスキューボタンのパーツ
  Widget _buildRescueButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 4),
        const Text("友達救済", style: TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }
}