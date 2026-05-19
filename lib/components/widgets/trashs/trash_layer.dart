import 'package:flutter/material.dart';

import '../../models/state_theme.dart';
import '../../extensions/trash_layer_type.dart';
import '/components/models/trash_type_extension.dart';


class TrashLayer extends StatelessWidget {
  final StateTheme theme;
  final TrashLayerType layer;

  const TrashLayer({
    super.key,
    required this.theme,
    required this.layer,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: theme.trashes
          .where((trash) => trash.layer == layer)
          .map((trash) {
            return Positioned(
              left: trash.x,
              top: trash.y,
              child: Transform.rotate(
                angle: trash.rotation * 3.141592 / 180,
                child: Image.asset(
                  trash.type.image,
                  width: trash.width,
                  height: trash.height,
                  fit: BoxFit.contain,
                ),
              ),
            );
          }).toList(),
    );
  }
}