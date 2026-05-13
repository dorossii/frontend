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
        onTap(pages[index]);
      },
      isTop: isTop,
    );
  }
}