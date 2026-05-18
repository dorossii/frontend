import '../models/trash_type.dart';

// ゴミの種類に応じた画像を定義するエクステンション
extension TrashTypeExtension on TrashType {
  String get image {
    switch (this) {
      case TrashType.rightBanana:
        return 'images/trash/trash_5.webp';
      case TrashType.leftBanana:
        return 'images/trash/trash_1.webp';
      case TrashType.leftTrashPink:
        return 'images/trash/trash_11.webp';
      case TrashType.leftTrashBlue:
        return 'images/trash/trash_10.webp';
      case TrashType.leftTrashGreen:
        return 'images/trash/trash_8.webp';
      case TrashType.rightTrashYellow:
        return 'images/trash/trash_6.webp';
      case TrashType.leftTrashYellow:
        return 'images/trash/trash_13.webp';
      case TrashType.rightTrashRed:
        return 'images/trash/trash_9.webp';
      case TrashType.leftTrashRed:
        return 'images/trash/trash_12.webp';
      case TrashType.leftTrashGray:
        return 'images/trash/trash_4.webp';
      case TrashType.rightMilk:
        return 'images/trash/trash_3.webp';
      case TrashType.leftMilk:
        return 'images/trash/trash_7.webp';
      case TrashType.backTrashBlue:
        return 'images/trash/trash_2.webp';
      case TrashType.backTrashGray:
        return 'images/trash/trash_14.webp';
    }
  }
}
