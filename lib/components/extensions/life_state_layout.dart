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
              'images/home/home_dirty.webp',

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
      // critical
      // ========================================
      case LifeState.critical:

        return StateTheme(

          background:
              'images/home/home_dirty.webp',

          character:
              'assets/chara/critical.webp',

          darkness: 0,

          trashes: [],
        );

      // ========================================
      // danger
      // ========================================
      case LifeState.danger:

        return StateTheme(

          background:
              'images/home/home_dirty.webp',

          character:
              'assets/chara/danger.webp',

          darkness: 0,

          trashes: [],
        );

      // ========================================
      // dirty
      // ========================================
      case LifeState.dirty:

        return StateTheme(

          background:
              'images/home/home_dirty.webp',

          character:
              'assets/chara/dirty.webp',

          darkness: 0,

          trashes: [],
        );
      // ========================================
      // normal
      // ========================================
      case LifeState.normal:

        return StateTheme(

          background:
              'images/home/home_normal.webp',

          character:
              'assets/chara/normal.webp',

          darkness: 0,

          trashes: [],
        );
      // ========================================
      // slightlyDirty
      // ========================================
      case LifeState.slightlyDirty:

        return StateTheme(

          background:
              'images/home/home_normal.webp',

          character:
              'assets/chara/slightlyDirty.webp',

          darkness: 0,

          trashes: [],
        );
      // ========================================
      // CLEAN
      // ========================================
      case LifeState.clean:

        return StateTheme(

          background:
              'images/home/home_normal.webp',

          character:
              'assets/chara/clean.webp',

          darkness: 0,

          trashes: [],
        );

        // ========================================
      // perfect
      // ========================================
      case LifeState.perfect:

        return StateTheme(

          background:
              'images/home/home_clean.webp',

          character:
              'assets/chara/perfect.webp',

          darkness: 0,

          trashes: [],
        );
      // ========================================
      // GOD
      // ========================================
      case LifeState.god:

        return StateTheme(

          background:
              'images/home/home_clean.webp',

          character:
              'assets/chara/god.webp',

          darkness: 0,

          trashes: [],
        );
    }
  }
}