import 'package:flutter/material.dart';
import '../../views/app.dart';
import 'header_view.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final PageType currentPage;

  const AppHeader({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final isTop = currentPage == PageType.top;

    return HeaderView(
      title: _getTitle(),
      showBackButton: !isTop, 
    );
  }

  String _getTitle() {
    switch (currentPage) {
      case PageType.top:
        return 'Top';
      case PageType.task:
        return 'Task';
      case PageType.friend:
        return 'Friend';
      case PageType.setting:
        return 'Setting';
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}