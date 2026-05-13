import 'package:flutter/material.dart';
import '../../views/app.dart';
import 'footer_view.dart';

class AppFooter extends StatelessWidget {
  final PageType? currentPage;
  final Function(PageType) onTap;

  const AppFooter({
    super.key,
    this.currentPage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // top判定ロジック
    final isTop = currentPage == PageType.top;

    return FooterView(
      // FooterView側がPageType?を受け取るようにしたので、そのまま渡す
      currentPage: currentPage, 
      onTap: (index) {
        // indexとPageTypeを対応させて親に通知
        final pages = [
          PageType.top, 
          PageType.task, 
          PageType.friend, 
          PageType.setting
        ];
        final targetPage = pages[index];
        
       if (currentPage == null) {
    // 1. まず、親（App.dart）のタブを切り替える指示を出す
    // これにより、詳細画面の「裏側」で画面が切り替わります
    onTap(targetPage);

    // 2. ほんの少しだけ待ってから、詳細画面（自分）を閉じる
    // これで「真っ暗」な隙間を作らずに済みます
    Future.delayed(const Duration(milliseconds: 50), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  } else {
    onTap(targetPage);
  }
      },
      isTop: isTop,
    );
  }
}