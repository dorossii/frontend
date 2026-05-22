import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../components/colors.dart';
import '../../app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int selectedIndex = 0;
  Timer? _animationTimer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _goNext();
  }

  /// 4つの画像を順番に拡大縮小
  void _startAnimation() {
    _animationTimer = Timer.periodic(
      const Duration(milliseconds: 450),
      (_) {
        if (!mounted) return;

        setState(() {
          selectedIndex = (selectedIndex + 1) % 4;
        });
      },
    );
  }

  /// 3秒後にホームへ
  void _goNext() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const App(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
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
        child: Image.asset(
          imagePath,
          width: 55,
          height: 55,
        ),
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

            /// 上：4つ画像
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
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Spacer(),

            /// 吹き出し
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'おそうじ中...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// キャラ
            Image.asset(
              'images/splash/milk.webp',
              width: 150,
              height: 150,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}