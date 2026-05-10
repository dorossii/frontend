import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF005B5C);
  static const Color btnBackground = Color(0xFF55A871);
  static const Color subBackground = Color(0xFFA1CBC5);
  static const Color subWhiteBackground = Color(0xFFF9F6EE);
  static const Color sub = Color(0xFFFFDB4D);
  static const Color edgew = Color(0xFF004E4F);
  static const Color text = Color(0xFF033535);


  // ゴールドのグラデーション（上から下）
  static const Gradient goldGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFDB4D),
      Color(0xFFAD7B23),
    ],
  );
}

// グラデーション
class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final Gradient gradient;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      // AppColorsから渡されたグラデーションを適用
      shaderCallback: (bounds) => gradient.createShader(bounds),
      // textの形に切り抜く。
      // colorを白にしないとグラデーションが反映されないので、強制的に白にする。
      child: Text(
        text,
        style: (style ?? const TextStyle()).copyWith(color: Colors.white),
      ),
    );
  }
}