// ゴミ箱に入れるオブジェクトのクラス
class TrashObject {

  /// 画像
  final String image;

  /// 配置位置
  final double x;
  final double y;

  /// サイズ
  final double width;
  final double height;

  /// 回転
  final double rotation;

  const TrashObject({
    required this.image,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.rotation = 0,
  });
}