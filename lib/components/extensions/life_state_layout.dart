import '../models/status.dart';
import '../models/state_theme.dart';
import '../models/character_animation_type.dart';
import '../models/trashs.dart';
import '../models/trash_type.dart';
import '../models/trash_animation_type.dart';
import '../extensions/trash_layer_type.dart';

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

          trashes: [
            TrashObject(
              type: TrashType.rightBanana,
              x: 50,
              y: 400,
              width: 50,
              height: 50,
              rotation: -20,
              animation: TrashAnimationType.floating,
              layer: TrashLayerType.front,
            ),
          ],
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

          trashes: [
            TrashObject(
                  type: TrashType.backTrashGray,
                  x: 40,
                  y: 130,
                  width: 250,
                  height: 250,
                  rotation: 0,
                  animation: TrashAnimationType.shaking,
                  layer: TrashLayerType.back,
                ),
            TrashObject(
              type: TrashType.rightBanana,
              x: 230,
              y: 340,
              width: 50,
              height: 50,
              rotation: 0,
              animation: TrashAnimationType.floating,
              layer: TrashLayerType.front,
            ),
            TrashObject(
              type: TrashType.leftTrashPink,
              x: 280,
              y: 240,
              width: 30,
              height: 30,
              rotation: 0,
              animation: TrashAnimationType.shaking,
              layer: TrashLayerType.front,
            ),
            TrashObject(
                type: TrashType.leftTrashGreen,
                x: 140,
                y: 300,
                width: 45,
                height: 45,
                rotation: -18,
                animation: TrashAnimationType.floating,
                layer: TrashLayerType.back,
              ),
            TrashObject(
                type: TrashType.rightTrashYellow,
                x: 45,
                y: 390,
                width: 70,
                height: 70,
                rotation: 0,
                animation: TrashAnimationType.shaking,
                layer: TrashLayerType.front,
              ),
            TrashObject(
                type: TrashType.leftTrashYellow,
                x: 35,
                y: 270,
                width: 60,
                height: 60,
                rotation: 0,
                animation: TrashAnimationType.bouncing,
                layer: TrashLayerType.front,
              ),
              TrashObject(
              type: TrashType.leftTrashBlue,
              x: 32,
              y: 310,
              width: 30,
              height: 30,
              rotation: 0,
              animation: TrashAnimationType.bouncing,
              layer: TrashLayerType.front,
            ),
            TrashObject(
                type: TrashType.leftMilk,
                x: 150,
                y: 380,
                width: 80,
                height: 80,
                rotation: -160,
                animation: TrashAnimationType.floating,
                layer: TrashLayerType.front,
              ),
            TrashObject(
                type: TrashType.leftTrashGray,
                x: 300,
                y: 218,
                width: 55,
                height: 55,
                rotation: 0,
                animation: TrashAnimationType.floating,
                layer: TrashLayerType.front,
              ),  
            TrashObject(
                type: TrashType.leftTrashRed,
                x: 300,
                y: 350,
                width: 120,
                height: 120,
                rotation: 0,
                animation: TrashAnimationType.floating,
                layer: TrashLayerType.front,
              ),
          ],
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

          trashes: [
            TrashObject(
              type: TrashType.leftBanana,
              x: 230,
              y: 340,
              width: 50,
              height: 50,
              rotation: 0,
              animation: TrashAnimationType.floating,
              layer: TrashLayerType.front,
            ),
            TrashObject(
                type: TrashType.leftTrashGray,
                x: 280,
                y: 240,
                width: 30,
                height: 30,
                rotation: 0,
                animation: TrashAnimationType.shaking,
                layer: TrashLayerType.front,
              ),
            TrashObject(
                  type: TrashType.leftTrashRed,
                  x: 140,
                  y: 300,
                  width: 70,
                  height: 70,
                  rotation: -18,
                  animation: TrashAnimationType.floating,
                  layer: TrashLayerType.back,
                ),
                TrashObject(
                type: TrashType.leftMilk,
                x: 280,
                y: 240,
                width: 30,
                height: 30,
                rotation: 0,
                animation: TrashAnimationType.shaking,
                layer: TrashLayerType.front,
              ),

          ],
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

          trashes: [
            TrashObject(
              type: TrashType.leftTrashGray,
              x: -10,
              y: 0,
              width: 55,
              height: 55,
              rotation: -180,
              animation: TrashAnimationType.bouncing,
              layer: TrashLayerType.front,
            ),
            TrashObject(
                type: TrashType.leftTrashGreen,
                x: 320,
                y: 320,
                width: 40,
                height: 40,
                rotation: 10,
                animation: TrashAnimationType.bouncing,
                layer: TrashLayerType.front,
              ),
            TrashObject(
                type: TrashType.rightBanana,
                x: 0,
                y: 400,
                width: 60,
                height: 60,
                rotation: 0,
                animation: TrashAnimationType.bouncing,
                layer: TrashLayerType.front,
              ),
          ],
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

          trashes: [
            TrashObject(
              type: TrashType.blueBroom,
              x: 210,
              y: 290,
              width: 210,
              height: 210,
              rotation: 5,
              animation: TrashAnimationType.floating,
              layer: TrashLayerType.front,
            ),
              TrashObject(
                type: TrashType.redBroom,
                x: 0,
                y: 300,
                width: 200,
                height: 200,
                rotation: 0,
                animation: TrashAnimationType.floating,
                layer: TrashLayerType.front,
              ),
          ],
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
