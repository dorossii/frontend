import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;

  const HeaderView({
    super.key,
    required this.title,
    required this.showBackButton,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),

      // 戻るボタン制御
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,

      // デザインはここに集約
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    );
  }

  // AppBar使うために必要
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}