import 'package:flutter/material.dart';

class TrashItem extends StatelessWidget {

  final String image;

  final double width;
  final double height;

  final double rotation;

  const TrashItem({
    super.key,
    required this.image,
    required this.width,
    required this.height,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {

    return Transform.rotate(
      angle: rotation,

      child: Image.asset(
        image,
        width: width,
        height: height,
      ),
    );
  }
}