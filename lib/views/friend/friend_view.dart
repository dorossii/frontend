import 'package:flutter/material.dart';
import 'friend_view_model.dart';
import 'package:authbase_mobile/components/colors.dart';

class FriendView extends StatelessWidget {
  final FriendViewModel viewModel;

  const FriendView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.subWhiteBackground, 
      body: Column(
        children: [
          // フレンドを追加ボタン
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: TextButton.icon(
                onPressed: () {
                  // 追加処理
                },
                icon: Image.asset('images/friend+.png', width: 18, height: 18),
                label: const Text(
                  "フレンドを追加",
                  style: TextStyle(
                    color: Color(0xFF002D2C),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'textFont',
                  ),
                ),
              ),
            ),
          ),

          // 検索バー
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: '検索',
                prefixIcon: const Icon(Icons.search, color: Colors.black26),
                filled: true,
                fillColor: AppColors.grayBackground,
                hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontFamily: 'textFont'),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // フレンドリスト
          Expanded(
            child: ListView(
              children: [
                _buildFriendItem("大阪 太郎", 0.7, 'images/icon1.png'),
                _buildFriendItem("東京 花子", 0.4, 'images/icon2.png'),
                _buildFriendItem("名古屋 次郎", 0.9, 'images/icon3.png'),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(String name, double hpValue, String mainImagePath) {
      // HPの値に応じて右下のキャラクター画像（ステータス画像）を決定する
      String statusImagePath;
      if (hpValue > 0.6) {
        statusImagePath = 'images/status/godIcon.png';   // 神
      } else if (hpValue > 0.3) {
        statusImagePath = 'images/status/humanIcon.png';   // 普通
      } else {
        statusImagePath = 'images/status/zombieIcon.png'; // ゾンビ状態
      }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Row(
        children: [
          // アイコン部分
          Stack(
          clipBehavior: Clip.none, // キャラクターのはみ出しを許可
          children: [
            // メインの丸アイコン
            CircleAvatar(
              radius: 35,
              backgroundColor: const Color(0xFF638D87),
              backgroundImage: AssetImage(mainImagePath),
            ),
            // 右下のキャラクター（HP連動）
            Positioned(
              right: -10,
              bottom: -10,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    statusImagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
          const SizedBox(width: 15),

          // 名前とHPゲージ
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C2C2C), fontFamily: 'textFont'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text("HP ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF004D4B), fontFamily: 'textFont')),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: hpValue,
                          minHeight: 12,
                          backgroundColor: const Color(0xFFEBEBEB),
                          // HPの色を緑系に設定
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8BC34A)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),

          // フレンドのお家に行くボタン
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.btnBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset('images/friend_go.png', width: 24, height: 24)
    );
  }
}