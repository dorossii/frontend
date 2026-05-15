import 'trashs.dart';
import 'character_animation_type.dart';

/// ===============================
/// 状態ごとのUIセット
/// ===============================
class StateTheme {

  /// 背景画像
  final String background;

  /// キャラ画像
  final String character;

  /// キャラクターサイズ
  final double characterHeight;

  /// アニメーション
  final CharacterAnimationType animation;

  /// ステータスの説明文
  final String description;

  /// ゴミ配置
  final List<TrashObject> trashes;

  /// 背景暗さ
  final double darkness;

  const StateTheme({
    required this.background,
    required this.character,
    required this.characterHeight,
    this.animation =CharacterAnimationType.none,
    this.description = '普通の状態です',
    required this.trashes,
    required this.darkness,
  });
}