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
      isTop: isTop, 
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}