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

    return FooterView(
      currentIndex: _getIndex(currentPage),
      onTap: (index) {
        // indexとPageTypeを対応させる
        final pages = [PageType.top, PageType.task, PageType.friend, PageType.setting];
        onTap(pages[index]);
      },
      isTop: isTop,
    );
  }

  int _getIndex(PageType page) {
    switch (page) {
      case PageType.top: return 0;
      case PageType.task: return 1;
      case PageType.friend: return 2;
      case PageType.setting: return 3;
    }
  }
}