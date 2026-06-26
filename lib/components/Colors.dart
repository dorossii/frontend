import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF005B5C);
  static const Color darkBackground = Color(0xFF004E4F);
  static const Color btnBackground = Color(0xFF55A871);
  static const Color subBackground = Color(0xFFA1CBC5);
  static const Color subWhiteBackground = Color(0xFFF9F6EE);
  static const Color sub = Color(0xFFFFDB4D);
  static const Color edgew = Color(0xFF004E4F);
  static const Color darkEdgey = Color(0xFF002222);
  static const Color text = Color(0xFF033535);
  static const Color grayBackground = Color(0xFFEEEEEE);
  static const Color gray = Color(0xFF7A867E);
  static const Color black = Color(0x00000000);

// アイコンのカラー
  static const Color icon1 = Color(0xFF3D7D73);
  static const Color icon2 = Color(0xFF7F88C1);
  static const Color icon3 = Color(0xFFB05959);
  static const Color icon4 = Color(0xFFECA850);
  static const Color icon5 = Color(0xFFA1CBC5);
  static const Color icon6 = Color(0xFFFFB6C1);
  static const Color icon7 = Color(0xFFBFCDFF);
  static const Color icon8 = Color(0xFFBFECE6);


static Color getBackgroundColor(
  String background,
) {

  switch (background) {

    case 'icon1':
      return AppColors.icon1;

    case 'icon2':
      return AppColors.icon2;

    case 'icon3':
      return AppColors.icon3;

    case 'icon4':
      return AppColors.icon4;

    case 'icon5':
      return AppColors.icon5;

    case 'icon6':
      return AppColors.icon6;

    case 'icon7':
      return AppColors.icon7;

    case 'icon8':
      return AppColors.icon8;

    default:
      return Colors.grey;
  }
}
  

  // 緑のグラデーション（上から下）
  static const Gradient greenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF55A871),
      Color(0xFF62C884),
    ],
  );
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

// グラデーションボタン
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.imagePath,
    required this.gradient,
    this.onTap,
  });

  final String imagePath;
  final Gradient gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          gradient: gradient, 
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(imagePath, width: 24, height: 24),
        ),
      ),
    );
  }
}