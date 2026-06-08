import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../../../components/colors.dart';
import './chara_massages.dart';
import '../../app.dart';

class LoginSplashScreen extends StatefulWidget {
  const LoginSplashScreen({super.key});

  @override
  State<LoginSplashScreen> createState() => _LoginSplashScreenState();
}

class _LoginSplashScreenState extends State<LoginSplashScreen> {
  int selectedIndex = 0;
  Timer? _animationTimer;
  Timer? _milkTimer;

  bool isMilkUp = false;

late String currentMessage;

  @override
  void initState() {
    super.initState();

    currentMessage = CharaMessages[Random().nextInt(CharaMessages.length)];

    _startAnimation();
    _startMilkFloat();
    _goNext();
  }

  /// 上の4つアイコン
  void _startAnimation() {
    _animationTimer = Timer.periodic(const Duration(milliseconds: 450), (_) {
      if (!mounted) return;

      setState(() {
        selectedIndex = (selectedIndex + 1) % 4;
      });
    });
  }

  /// 吹き出し + milk ふわふわ
  void _startMilkFloat() {
    _milkTimer = Timer.periodic(const Duration(milliseconds: 800), (_) {
      if (!mounted) return;

      setState(() {
        isMilkUp = !isMilkUp;
      });
    });
  }

  /// 3秒後ホームへ
  void _goNext() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const App()),
      );
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    _milkTimer?.cancel();
    super.dispose();
  }

  Widget _buildAnimatedItem(int index, String imagePath) {
    final isSelected = selectedIndex == index;

    return AnimatedScale(
      scale: isSelected ? 1.3 : 0.85,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Image.asset(imagePath, width: 55, height: 55),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),

            /// 上4つアイコン
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedItem(0, 'images/splash/trash_blue.webp'),
                _buildAnimatedItem(1, 'images/splash/trash_green.webp'),
                _buildAnimatedItem(2, 'images/splash/trash_red.webp'),
                _buildAnimatedItem(3, 'images/splash/trash_yellow.webp'),
              ],
            ),

            const SizedBox(height: 40),

            /// Loading
            Column(
              children: const [
                GradientText(
                  'loading...',
                  gradient: AppColors.goldGradient,
                  style: TextStyle(
                    fontFamily: 'LogoFont',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),

            const Spacer(),

            /// 吹き出し + milk
            AnimatedSlide(
              offset: isMilkUp ? const Offset(0, -0.04) : const Offset(0, 0.04),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: isMilkUp ? 1.03 : 0.97,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// 吹き出し
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 70),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: Text(
                                currentMessage,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'TextFont',
                                  color: AppColors.text,
                                ),
                              ),
                            ),

                            /// 中央から右下へ斜めしっぽ
                            Align(
                              alignment: Alignment.center,
                              child: CustomPaint(
                                size: const Size(26, 18),
                                painter: BubbleTailPainter(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// milk 右寄せ
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset(
                          'images/splash/milk.webp',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class BubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    /// 上左
    path.moveTo(0, 0);

    /// 上右
    path.lineTo(size.width, 0);

    /// 右下（milk方向）
    path.lineTo(size.width * 1.8, size.height * 1.7);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
