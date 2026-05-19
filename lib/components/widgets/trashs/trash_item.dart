// ==============================================
// widgets/trash/trash_item.dart
// ==============================================

import 'package:flutter/material.dart';

import '../../models/trash_type_extension.dart';
import '../../models/trashs.dart';

class TrashItem extends StatelessWidget {

  final TrashObject trash;

  const TrashItem({
    super.key,
    required this.trash,
  });

  @override
  Widget build(BuildContext context) {

    return Transform.rotate(
      angle: trash.rotation,

      child: Image.asset(
        trash.type.image,

        width: trash.width,
        height: trash.height,
      ),
    );
  }
}