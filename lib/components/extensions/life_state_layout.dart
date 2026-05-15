import '../models/status.dart';
import '../models/state_theme.dart';
import '../models/trash_animation_type.dart';
import '../models/trashs.dart';
import '../models/trash_type.dart';

// LifeStateに応じたテーマを定義するエクステンション
extension LifeStateExtension on LifeState {

  StateTheme get theme {

    switch (this) {

      // ========================================
      // RIP
      // ========================================
      case LifeState.rip:

        return StateTheme(

          background:
              'assets/bg/rip_bg.webp',

          character:
              'assets/chara/rip.webp',

          darkness: 0.9,

          trashes: [

            TrashObject(
              type: TrashType.mountain,

              x: 0.5,
              y: 0.8,

              width: 240,
              height: 240,

              animation:
                  TrashAnimationType.shaking,
            ),

            TrashObject(
              type: TrashType.pizza,

              x: 0.8,
              y: 0.85,

              width: 100,
              height: 100,

              rotation: 0.4,

              animation:
                  TrashAnimationType.floating,
            ),
          ],
        );

      // ========================================
      // CLEAN
      // ========================================
      case LifeState.clean:

        return StateTheme(

          background:
              'assets/bg/clean_bg.webp',

          character:
              'assets/chara/clean.webp',

          darkness: 0,

          trashes: [],
        );

      // ========================================
      // GOD
      // ========================================
      case LifeState.god:

        return StateTheme(

          background:
              'assets/bg/god_bg.webp',

          character:
              'assets/chara/god.webp',

          darkness: 0,

          trashes: [],
        );

      // ========================================
      // DEFAULT
      // ========================================
      default:

        return StateTheme(

          background:
              'assets/bg/default_bg.webp',

          character:
              'assets/chara/default.webp',

          darkness: 0.2,

          trashes: [],
        );
    }
  }
}