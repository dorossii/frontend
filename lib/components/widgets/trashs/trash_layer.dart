import 'package:flutter/material.dart';

import '../../models/status.dart';
import '../../extensions/life_state_layout.dart';

import 'trash_item.dart';

class TrashLayer extends StatelessWidget {

  final LifeState state;

  const TrashLayer({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {

    final trashList = state.trashLayout;

    final size = MediaQuery.of(context).size;

    return Stack(
      children: [

        ...trashList.map((trash) {

          return Positioned(
            left: size.width * trash.x,
            top: size.height * trash.y,

            child: TrashItem(
              image: trash.image,
              width: trash.width,
              height: trash.height,
              rotation: trash.rotation,
            ),
          );
        }),
      ],
    );
  }
}