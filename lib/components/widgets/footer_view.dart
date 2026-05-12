import 'package:flutter/material.dart';
import '../../components/colors.dart';

class FooterView extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isTop;

  const FooterView({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isTop,
  });

  @override
  Widget build(BuildContext context) {
    // アイコンのスタイルを統一するための関数
    final List<BottomNavigationBarItem> items = [
      _buildStyledItem("images/footer/home_icon.png", "Top", 0),
      _buildStyledItem("images/footer/task_icon.png", "Task", 1),
      _buildStyledItem("images/footer/friend_icon.png", "Friend", 2),
      _buildStyledItem("images/footer/setting_icon.png", "Setting", 3),
    ];

    return Container(
      decoration: BoxDecoration(
        // 背景色と、トップページ以外のときの上部の金色の線と影
        color: AppColors.background, 
        border: isTop ? null : const Border(
          top: BorderSide(color: AppColors.sub, width: 1.5),
        ),
        boxShadow: isTop ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent, 
        elevation: 0,
        selectedItemColor:  AppColors.sub,
        unselectedItemColor: AppColors.gray,
        selectedLabelStyle: const TextStyle(fontFamily: 'textFont', fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontFamily: 'textFont', fontSize: 12),
        showUnselectedLabels: true,
      ),
    );
  }

  BottomNavigationBarItem _buildStyledItem(String iconPath, String label, int index) {
    final bool isActive = currentIndex == index;
    
    // カラーパレットの精細化
    final Color outerBorder = isActive ? const Color(0xFF8E732A) : const Color(0xFF3D4540); // 外枠
    final Color innerBorder = isActive ? AppColors.edgew : const Color(0xFF7A867E); // 内枠
    final List<Color> tileGradient = isActive 
        ? [const Color(0xFF62C884), const Color(0xFF55A871)] // アクティブ時の緑グラデ
        : [const Color(0xFF4A544E), const Color(0xFF353D38)]; // 非アクティブ時の沈んだ色

    return BottomNavigationBarItem(
      icon: Container(
        width: 46,
        height: 46,
        margin: const EdgeInsets.only(bottom: 4, top: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // 外側の「厚み」を表現する暗い縁
          border: Border.all(color: outerBorder, width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(0, 3), blurRadius: 4),
          ],
        ),
        child: Container(
          // 内側のハイライト縁
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: innerBorder, width: 1.5),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: tileGradient,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // アイコンの彫り込み（ドロップシャドウ）
              Image.asset(iconPath, width: 26, height: 26, color: Colors.black.withOpacity(0.5)),
              // アイコン本体
              Padding(
                padding: const EdgeInsets.only(top: 1), // わずかに上に
                child: Image.asset(
                  iconPath,
                  width: 32,
                  height: 32,
                  color: isActive ? null: AppColors.gray
                ),
              ),
            ],
          ),
        ),
      ),
      label: label,
    );
  }
}