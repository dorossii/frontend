import 'trash_animation_type.dart';
import 'trash_type.dart';
import '../extensions/trash_layer_type.dart';

// ゴミ箱に入れるオブジェクトのクラス
class TrashObject {
  /// ゴミ種類
  final TrashType type;

  /// 位置
  final double x;
  final double y;

  /// サイズ
  final double width;
  final double height;

  /// 回転
  final double rotation;

  /// アニメーション
  final TrashAnimationType animation;

  // レイヤー
  final TrashLayerType layer;

  const TrashObject({
    required this.type,
    required this.x,
    required this.y,
    required this.width,
    required this.height,

    this.rotation = 0,

    this.animation = TrashAnimationType.none,
    this.layer = TrashLayerType.front,
  });
}
