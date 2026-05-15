// ==============================================
// widgets/trash/trash_layer.dart
// ==============================================

import 'package:flutter/material.dart';

import '../../models/state_theme.dart';

import 'trash_animation_wrapper.dart';
import 'trash_item.dart';

class TrashLayer extends StatelessWidget {

  final StateTheme theme;

  const TrashLayer({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {

    final size =
        MediaQuery.of(context).size;

    return Stack(
      children: [

        ...theme.trashes.map((trash) {

          return Positioned(
            left: size.width * trash.x,
            top: size.height * trash.y,

            child: TrashAnimationWrapper(

              animation:
                  trash.animation,

              child: TrashItem(
                trash: trash,
              ),
            ),
          );
        }),
      ],
    );
  }
}