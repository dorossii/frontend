import '../models/status.dart';
import '../models/state_theme.dart';
import '../models/character_animation_type.dart';

// LifeStateに応じたテーマを定義するエクステンション
extension LifeStateExtension on LifeState {
  StateTheme get theme {
    switch (this) {
      // ========================================
      // RIP
      // ========================================
      case LifeState.rip:
        return StateTheme(
          background: 'images/home/home_dirty.webp',

          character: 'images/chara/rip.webp',

          characterHeight: 200,

          animation: CharacterAnimationType.none,

          description: '手遅れです...',

          darkness: 0.9,

          trashes: [],
        );

      // ========================================
      // critical
      // ========================================
      case LifeState.critical:
        return StateTheme(
          background: 'images/home/home_dirty.webp',

          character: 'images/chara/critical.webp',

          characterHeight: 200,

          animation: CharacterAnimationType.twitch,

          description: '限界だよ...',

          darkness: 0,

          trashes: [],
        );

      // ========================================
      // danger
      // ========================================
      case LifeState.danger:
        return StateTheme(
          background: 'images/home/home_dirty.webp',

          character: 'images/chara/danger.webp',

          characterHeight: 300,

          animation: CharacterAnimationType.wobble,

          description: 'ゾンビになっちゃった',

          darkness: 0,

          trashes: [],
        );

      // ========================================
      // dirty
      // ========================================
      case LifeState.dirty:
        return StateTheme(
          background: 'images/home/home_dirty.webp',

          character: 'images/chara/dirty.webp',

          characterHeight: 320,

          animation: CharacterAnimationType.tired,

          description: '汚くなってきたかも',

          darkness: 0,

          trashes: [],
        );
      // ========================================
      // normal
      // ========================================
      case LifeState.normal:
        return StateTheme(
          background: 'images/home/home_normal.webp',

          character: 'images/chara/normal.webp',

          characterHeight: 320,

          animation: CharacterAnimationType.breathing,
          description: '少し汚くなってきた',

          darkness: 0,

          trashes: [],
        );
      // ========================================
      // slightlyDirty
      // ========================================
      case LifeState.slightlyDirty:
        return StateTheme(
          background: 'images/home/home_normal.webp',

          character: 'images/chara/slightlyDirty.webp',

          characterHeight: 320,

          animation: CharacterAnimationType.breathing,
          description: 'まだまだ大丈夫',

          darkness: 0,

          trashes: [],
        );
      // ========================================
      // CLEAN
      // ========================================
      case LifeState.clean:
        return StateTheme(
          background: 'images/home/home_normal.webp',

          character: 'images/chara/clean.webp',

          characterHeight: 320,

          animation: CharacterAnimationType.bounce,
          description: 'きれいになった！',

          darkness: 0,

          trashes: [],
        );

      // ========================================
      // perfect
      // ========================================
      case LifeState.perfect:
        return StateTheme(
          background: 'images/home/home_clean.webp',

          character: 'images/chara/perfect.webp',

          characterHeight: 340,

          animation: CharacterAnimationType.floating,
          description: '完璧な状態！',

          darkness: 0,

          trashes: [],
        );
      // ========================================
      // GOD
      // ========================================
      case LifeState.god:
        return StateTheme(
          background: 'images/home/home_clean.webp',

          character: 'images/chara/god.webp',

          characterHeight: 340,

          animation: CharacterAnimationType.floating,
          description: '神の領域！',

          darkness: 0,

          trashes: [],
        );
    }
  }
}
