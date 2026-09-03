import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../components/colors.dart';
import '../../app.dart';

class TaskAnimationScreen extends StatefulWidget {
  const TaskAnimationScreen({super.key, required this.labelText});

  final String labelText;

  @override
  State<TaskAnimationScreen> createState() => _TaskAnimationScreenState();
}

class _TaskAnimationScreenState extends State<TaskAnimationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    _controller.forward().then((_) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const App()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SizedBox(
          width: 360,
          height: 360,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              final t = Curves.easeInOut.transform(_controller.value);

              // 箒
              final broomX = -120 + 260 * t;
              final broomY = sin(t * pi * 2) * 6;
              final broomAngle = -0.32 + 0.12 * sin(t * pi);

              // ゴミ初期位置
              double trashX = 135;

              double bananaY = 35;
              double milkY = 18;
              double blackY = 25;

              double bananaRotate = 0;
              double milkRotate = 0;
              double blackRotate = 0;

              final hit = t > 0.58;

              if (hit) {
                final p = (t - 0.58) / 0.42;

                trashX += 180 * p;

                bananaY += -22 * sin(p * pi);
                milkY += -10 * sin(p * pi);
                blackY += 10 * sin(p * pi);

                bananaRotate = 0.9 * p;
                milkRotate = -0.7 * p;
                blackRotate = 1.2 * p;
              }

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  /// バナナ
                  Positioned(
                    left: trashX,
                    bottom: bananaY,
                    child: Transform.rotate(
                      angle: bananaRotate,
                      child: Image.asset('images/task/banana.png', width: 70),
                    ),
                  ),

                  /// 牛乳
                  Positioned(
                    left: trashX + 60,
                    bottom: milkY,
                    child: Transform.rotate(
                      angle: milkRotate,
                      child: Image.asset(
                        'images/task/milk_gomi.png',
                        width: 70,
                      ),
                    ),
                  ),

                  /// 黒ゴミ
                  Positioned(
                    left: trashX + 110,
                    bottom: blackY,
                    child: Transform.rotate(
                      angle: blackRotate,
                      child: Image.asset(
                        'images/task/black_gomi.png',
                        width: 70,
                      ),
                    ),
                  ),

                  /// ほこり
                  if (hit)
                    Positioned(
                      left: broomX + 185,
                      bottom: 70,
                      child: Opacity(
                        opacity: 1 - ((t - 0.58) / 0.42).clamp(0.0, 1.0),
                        child: Transform.scale(
                          scale: 1 + ((t - 0.58) / 0.42),
                          child: const Text(
                            "💨",
                            style: TextStyle(fontSize: 70),
                          ),
                        ),
                      ),
                    ),

                  /// 箒
                  Positioned(
                    left: broomX,
                    bottom: -10 + broomY,
                    child: Transform.rotate(
                      angle: broomAngle,
                      child: Image.asset(
                        "images/task/broom_blue.png",
                        width: 280,
                      ),
                    ),
                  ),

                  /// メッセージ
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -60,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        child: Text(
                          widget.labelText,
                          // "${widget.friendName}さんにゴミを渡しています...",
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.subWhiteBackground,
                            fontFamily: "textFont",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
