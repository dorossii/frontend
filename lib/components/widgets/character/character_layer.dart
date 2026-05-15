import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/state_theme.dart';
import '../../models/character_animation_type.dart';

// キャラクターの表示とアニメーションを担当するレイヤー
class CharacterLayer extends StatefulWidget {

  final StateTheme theme;

  const CharacterLayer({
    super.key,
    required this.theme,
  });

  @override
  State<CharacterLayer> createState() =>
      _CharacterLayerState();
}

class _CharacterLayerState
    extends State<CharacterLayer>

    with TickerProviderStateMixin {

  // ==========================================
  // 常時アニメーション
  // ==========================================

  late AnimationController
      breathingController;

  late AnimationController
      wobbleController;

  late AnimationController
      tiredController;

  late AnimationController
      floatingController;

  // ==========================================
  // イベントアニメーション
  // ==========================================

  double twitchY = 0;

  double bounceY = 0;

  Timer? twitchTimer;

  Timer? bounceTimer;

  @override
  void initState() {

    super.initState();

    // ======================================
    // breathing
    // ======================================

    breathingController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(seconds: 2),

    )..repeat(reverse: true);

    // ======================================
    // wobble
    // ======================================

    wobbleController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(seconds: 2),

    )..repeat(reverse: true);

    // ======================================
    // tired
    // ======================================

    tiredController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(seconds: 3),

    )..repeat(reverse: true);

    // ======================================
    // floating
    // ======================================

    floatingController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(seconds: 4),

    )..repeat(reverse: true);

    // ======================================
    // イベントアニメ
    // ======================================

    startTwitch();

    startBounce();
  }

  @override
  void dispose() {

    breathingController.dispose();

    wobbleController.dispose();

    tiredController.dispose();

    floatingController.dispose();

    twitchTimer?.cancel();

    bounceTimer?.cancel();

    super.dispose();
  }

  // ==========================================
  // CRITICAL ビクッ
  // ==========================================

  void startTwitch() {

    twitchTimer = Timer.periodic(

      const Duration(seconds: 4),

      (_) async {

        if (widget.theme.animation !=
            CharacterAnimationType.twitch) {
          return;
        }

        setState(() {
          twitchY = -8;
        });

        await Future.delayed(
          const Duration(milliseconds: 120),
        );

        setState(() {
          twitchY = 0;
        });
      },
    );
  }

  // ==========================================
  // CLEAN ジャンプ
  // ==========================================

  void startBounce() {

    bounceTimer = Timer.periodic(

      const Duration(seconds: 5),

      (_) async {

        if (widget.theme.animation !=
            CharacterAnimationType.bounce) {
          return;
        }

        setState(() {
          bounceY = -12;
        });

        await Future.delayed(
          const Duration(milliseconds: 250),
        );

        setState(() {
          bounceY = 0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final animation =
        widget.theme.animation;

    Widget child = Image.asset(

      widget.theme.character,

      height:
          widget.theme.characterHeight,

      fit: BoxFit.contain,
    );

    // ========================================
    // breathing
    // ========================================

    if (animation ==
        CharacterAnimationType.breathing) {

      child = AnimatedBuilder(

        animation: breathingController,

        builder: (
          context,
          child,
        ) {

          /// 微上下
          final offset =

              -1 +

              (breathingController.value * 2);

          return Transform.translate(

            offset: Offset(0, offset),

            child: child,
          );
        },

        child: child,
      );
    }

    // ========================================
    // wobble
    // ========================================

    if (animation ==
        CharacterAnimationType.wobble) {

      child = AnimatedBuilder(

        animation: wobbleController,

        builder: (
          context,
          child,
        ) {

          /// 左右揺れ
          final offset =

              -4 +

              (wobbleController.value * 8);

          /// 少し回転
          final rotation =

              -0.02 +

              (wobbleController.value * 0.04);

          return Transform.translate(

            offset: Offset(offset, 0),

            child: Transform.rotate(

              angle: rotation,

              child: child,
            ),
          );
        },

        child: child,
      );
    }

    // ========================================
    // tired
    // ========================================

    if (animation ==
        CharacterAnimationType.tired) {

      child = AnimatedBuilder(

        animation: tiredController,

        builder: (
          context,
          child,
        ) {

          /// 少し沈む
          final offset =

              tiredController.value * 3;

          /// だるそうに傾く
          final rotation =

              -0.03 +

              (tiredController.value * 0.06);

          return Transform.translate(

            offset: Offset(0, offset),

            child: Transform.rotate(

              angle: rotation,

              child: child,
            ),
          );
        },

        child: child,
      );
    }

    // ========================================
    // floating
    // ========================================

    if (animation ==
        CharacterAnimationType.floating) {

      child = AnimatedBuilder(

        animation: floatingController,

        builder: (
          context,
          child,
        ) {

          final isGod =
              widget.theme.character
                  .contains('god');

          final offset = isGod

              // GOD
              ? -12 +
                  (floatingController.value
                      * 24)

              // PERFECT
              : -5 +
                  (floatingController.value
                      * 10);

          return Transform.translate(

            offset: Offset(0, offset),

            child: child,
          );
        },

        child: child,
      );
    }

    // ========================================
    // twitch
    // ========================================

    if (animation ==
        CharacterAnimationType.twitch) {

      child = Transform.translate(

        offset: Offset(0, twitchY),

        child: Transform.rotate(

          angle: twitchY == 0
              ? 0
              : -0.04,

          child: child,
        ),
      );
    }

    // ========================================
    // bounce
    // ========================================

    if (animation ==
        CharacterAnimationType.bounce) {

      child = Transform.translate(

        offset: Offset(0, bounceY),

        child: child,
      );
    }

    return Align(

      alignment: Alignment.bottomCenter,

      child: Padding(

        padding:
            const EdgeInsets.only(
              bottom: 180,
            ),

        child: child,
      ),
    );
  }
}