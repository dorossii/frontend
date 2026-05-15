// ==============================================
// widgets/trash/trash_animation_wrapper.dart
// ==============================================

import 'package:flutter/material.dart';

import '../../models/trash_animation_type.dart';

class TrashAnimationWrapper
    extends StatelessWidget {

  final Widget child;

  final TrashAnimationType animation;

  const TrashAnimationWrapper({
    super.key,
    required this.child,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {

    switch (animation) {

      case TrashAnimationType.floating:

        return TweenAnimationBuilder<double>(
          tween: Tween(
            begin: -5,
            end: 5,
          ),

          duration:
              const Duration(seconds: 2),

          curve: Curves.easeInOut,

          builder: (
            context,
            value,
            child,
          ) {

            return Transform.translate(
              offset: Offset(0, value),
              child: child,
            );
          },

          child: child,
        );

      default:
        return child;
    }
  }
}