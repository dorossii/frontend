import 'package:flutter/material.dart';

import '../../../components/Colors.dart';

class HpBar extends StatelessWidget {
  const HpBar({super.key, required this.value, this.height = 20});

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);

    final gradient = v <= 0.4
        ? const LinearGradient(colors: [Color(0xFFD53B2A), Color(0xFFFFDB4D)])
        : const LinearGradient(colors: [Color(0xFFFEE590), Color(0xFF55A871)]);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: MediaQuery.of(context).size.width * 0.6 * v,
              height: height,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        ),

        Text(
          "${(v * 100).round()}/100",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.text,
            fontFamily: "textFont",
          ),
        ),
      ],
    );
  }
}
