import 'package:flutter/material.dart';
import '../../components/colors.dart';

class FooterView extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Function(int) onTap;
  final bool isTop;

  const FooterView({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.isTop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: isTop ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, -4), // 上方向に影を出す
          ),
        ],
      ),
      child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,

      elevation: 0,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.background,
      showUnselectedLabels: true,
      ),
    );
  }
}