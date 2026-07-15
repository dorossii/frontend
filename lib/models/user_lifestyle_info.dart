/// 生活環境情報（初回登録用）
class UserLifestyleInfo {
  /// 一人暮らしかどうか
  final bool isAlone;

  /// 洗濯機の有無
  final bool hasWasher;

  /// 掃除機の有無
  final bool hasVacuum;

  /// ロボット掃除機の有無
  final bool hasRobot;

  /// 食器を使うかどうか
  final bool useTableware;

  /// 食洗機の有無
  final bool hasDishwasher;

  UserLifestyleInfo({
    required this.isAlone,
    required this.hasWasher,
    required this.hasVacuum,
    required this.hasRobot,
    required this.useTableware,
    required this.hasDishwasher,
  });

  Map<String, dynamic> toJson() {
    return {
      'isAlone': isAlone,
      'hasWasher': hasWasher,
      'hasVacuum': hasVacuum,
      'hasRobot': hasRobot,
      'useTableware': useTableware,
      'hasDishwasher': hasDishwasher,
    };
  }

  /// JSON → UserLifestyleInfo
  factory UserLifestyleInfo.fromJson(Map<String, dynamic> json) {
    return UserLifestyleInfo(
      isAlone: json['isAlone'] ?? false,
      hasWasher: json['hasWasher'] ?? false,
      hasVacuum: json['hasVacuum'] ?? false,
      hasRobot: json['hasRobot'] ?? false,
      useTableware: json['useTableware'] ?? false,
      hasDishwasher: json['hasDishwasher'] ?? false,
    );
  }
}
