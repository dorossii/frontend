import '../models/trash_type.dart';
// ゴミの種類に応じた画像を定義するエクステンション
extension TrashTypeExtension on TrashType {

  String get image {

    switch (this) {

      case TrashType.mountain:
        return
          '';

      case TrashType.pizza:
        return
          '';

      case TrashType.bottle:
        return
          '';

      case TrashType.can:
        return
          '';

      case TrashType.paper:
        return
          '';

      case TrashType.bag:
        return
          '';
    }
  }
}