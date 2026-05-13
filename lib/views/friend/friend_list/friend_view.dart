import 'package:flutter/material.dart';
import 'friend_view_model.dart';
import 'package:authbase_mobile/components/colors.dart';




class FriendListView extends StatelessWidget {
  final FriendListViewModel viewModel;

  const FriendListView({super.key, required this.viewModel});

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
                    fontWeight: FontWeight.normal,
                    fontFamily: 'textFont',
                  ),
                ),
              ),
            ),
          ),

          // 検索バー
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: SizedBox(
              height: 36, 
              child: TextField(
                style: const TextStyle(fontSize: 14), 
                decoration: InputDecoration(
                  hintText: '検索',
                  hintStyle: const TextStyle(fontSize: 14, color: AppColors.text, fontFamily: 'textFont'),
                  prefixIcon: const Icon(Icons.search, color: AppColors.text, size: 20),
                  filled: true,
                  fillColor: AppColors.grayBackground,
                  isDense: true, 
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12), 
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          
          // フレンドリスト
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildFriendItem(context,"yoh", 0.1, AppColors.icon8, 'images/icons/pineTree.png'),
                _buildFriendItem(context,"お猫様", 0.6, AppColors.icon3, 'images/icons/cafe.png'),
                _buildFriendItem(context,"saya", 0.4, AppColors.icon4, 'images/icons/bird.png'),
                _buildFriendItem(context,"ごろちゃん", 1.0, AppColors.icon5, 'images/icons/rocketCat.png'),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(BuildContext context, String name, double hpValue, Color iconColor, String mainImagePath) {
      // HPの値に応じて右下のキャラクター画像（ステータス画像）を決定する
      String statusImagePath;
      if (hpValue > 0.9) {
        statusImagePath = 'images/status/godIcon.png';   // 神
      } else if (hpValue > 0.4) {
        statusImagePath = 'images/status/humanIcon.png';   // 普通
      } else if (hpValue > 0.3) {
        statusImagePath = 'images/status/human2Icon.png'; // 普通の死にかけ
      } else {
        statusImagePath = 'images/status/zombieIcon.png';  // ゾンビ
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
              radius: 30,
              backgroundImage: AssetImage(mainImagePath),
              backgroundColor: iconColor,
            ),
            // 右下のキャラクター（HP連動）
            Positioned(
              right: -10,
              bottom: -10,
              child: Container(
                width: 35,
                height: 35,
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
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                
                HpBar(value: hpValue),
              ],
            ),
          ),
          const SizedBox(width: 15),

          // フレンドのお家に行くボタン
          _buildActionButton(context, name, iconColor),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String name, Color color) {
  return GradientButton(
    imagePath: 'images/friend_go.png',
    gradient: AppColors.greenGradient,
    onTap: () => viewModel.onFriendTapped(context, name, color),
  );
}
}


// hpゲージの色を緑系にするためのカスタムウィジェット
class HpBar extends StatelessWidget {
  const HpBar({
    super.key,
    required this.value, // 0.0 〜 1.0 の値
    this.height = 12.0,
  });

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    // 0.4以下なら赤系、0.5以上なら緑系のグラデーションを選択
    final gradient = value <= 0.4
        ? const LinearGradient(
            colors: [Color(0xFFD53B2A), Color(0xFFFFDB4D)], // ピンチ（赤）
          )
        : const LinearGradient(
            colors: [Color(0xFFFEE590), Color(0xFF55A871)], // 元気（緑）
          );

    return Row(
      children: [
        const Text(
          "HP ",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'textFont',
            color: AppColors.text,
          ),
        ),
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value.clamp(0.0, 1.0), // 念のため範囲を制限
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}