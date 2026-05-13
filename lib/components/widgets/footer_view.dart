import 'package:flutter/material.dart';
import '../../components/colors.dart';
import '../../views/app.dart';
class FooterView extends StatelessWidget {
  final PageType? currentPage;
  final Function(int) onTap;
  final bool isTop;

  const FooterView({
    super.key,
    this.currentPage, // requiredを外してnullを許容
    required this.onTap,
    required this.isTop,
  });

  @override
  Widget build(BuildContext context) {
    // 詳細画面（null）またはトップページの時は、上部の線と影を隠す
    final bool hideDecorator = isTop || currentPage == null;

    final List<BottomNavigationBarItem> items = [
      _buildStyledItem("images/footer/home_icon.png", "Top", 0),
      _buildStyledItem("images/footer/task_icon.png", "Task", 1),
      _buildStyledItem("images/footer/friend_icon.png", "Friend", 2),
      _buildStyledItem("images/footer/setting_icon.png", "Setting", 3),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background, 
        border: hideDecorator ? null : const Border(
          top: BorderSide(color: AppColors.sub, width: 1.5),
        ),
        boxShadow: hideDecorator ? [] : [
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
        currentIndex: _getSelectedIndex(currentPage), // メソッド名を統一
        onTap: onTap,
        backgroundColor: Colors.transparent, 
        elevation: 0,
        // currentPageがnullのときは、ラベルの色もグレーにする
        selectedItemColor: currentPage == null ? AppColors.gray : AppColors.sub,
        unselectedItemColor: AppColors.gray,
        selectedLabelStyle: const TextStyle(fontFamily: 'textFont', fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontFamily: 'textFont', fontSize: 12),
        showUnselectedLabels: true,
      ),
    );
  }

  BottomNavigationBarItem _buildStyledItem(String iconPath, String label, int index) {
    // ★ここがポイント：currentPageがnullのときは、強制的にfalseにする
    final bool isActive = currentPage != null && _getSelectedIndex(currentPage) == index;

    final List<Color> outerGradientColors = isActive 
      ? [const Color(0xFFFEE590), const Color(0xFFAD7B23)]
      : [const Color(0xFF7A867E), const Color(0xFF3D4540)];

    final Color innerBorder = isActive ? AppColors.edgew : const Color(0xFF7A867E);
    final List<Color> tileGradient = isActive 
        ? [const Color(0xFF62C884), const Color(0xFF55A871)]
        : [const Color(0xFF4A544E), const Color(0xFF353D38)];

    return BottomNavigationBarItem(
      icon: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.only(bottom: 4, top: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: outerGradientColors,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(0, 3), blurRadius: 4),
          ],
        ),
        padding: const EdgeInsets.all(2.5),
        child: Container(
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
              Image.asset(iconPath, width: 38, height: 38, color: Colors.black.withOpacity(0.5)),
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Image.asset(
                  iconPath,
                  width: 38,
                  height: 38,
                  color: isActive ? null : AppColors.gray,
                ),
              ),
            ],
          ),
        ),
      ),
      label: label,
    );
  }

  // 名前を統一し、ロジックを整理
  int _getSelectedIndex(PageType? type) {
    if (type == null) return 2; // お家のときはFriendの位置にインデックスを置いておく
    return type.index; 
  }
}