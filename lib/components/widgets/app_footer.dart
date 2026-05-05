import 'package:flutter/material.dart';
import '../../views/app.dart';
import 'footer_view.dart';

// 画面の状態と、タップ処理の状態をもたせる
class AppFooter extends StatelessWidget {
  final PageType currentPage;
  final Function(PageType) onTap;

  const AppFooter({
    super.key,
    required this.currentPage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isTop = currentPage == PageType.top;

    final items = isTop ? _topItems() : _defaultItems();
    final currentIndex = isTop ? 0 : _getIndex(currentPage);

    return FooterView(
      items: items,
      currentIndex: currentIndex,
      onTap: (index) {
        if (isTop) {
          if (index == 0) onTap(PageType.task);
          if (index == 1) onTap(PageType.friend);
          if (index == 2) onTap(PageType.setting);
        } else {
          if (index == 0) onTap(PageType.top);
          if (index == 1) onTap(PageType.task);
          if (index == 2) onTap(PageType.friend);
          if (index == 3) onTap(PageType.setting);
        }
      },
    );
  }

  List<BottomNavigationBarItem> _topItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friend'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
    ];
  }

  List<BottomNavigationBarItem> _defaultItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Top'),
      BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friend'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
    ];
  }

  int _getIndex(PageType page) {
    switch (page) {
      case PageType.top:
        return 0;
      case PageType.task:
        return 1;
      case PageType.friend:
        return 2;
      case PageType.setting:
        return 3;
    }
  }
}