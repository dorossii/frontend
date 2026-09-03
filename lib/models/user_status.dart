// ユーザーステータスを表すモデルクラス
class UserStatus {
  final String userId; // ユーザーID
  final int dirtLevel; // 汚さレベル
  final int healthPoint; // HP
  final String userName; // 名前
  final String userIcon; // ユーザーアイコン
  final String bgColors; // 背景色
  final int birthDate; // 生年月日
  final String livingType; // 居住タイプ

  UserStatus({
    required this.userId,
    required this.dirtLevel,
    required this.healthPoint,
    required this.userName,
    required this.userIcon,
    required this.bgColors,
    required this.birthDate,
    required this.livingType,
  });

  /// JSON → UserInfo
  factory UserStatus.fromJson(Map<String, dynamic> json) {
    return UserStatus(
      userId: json['userId'] ?? '',
      dirtLevel: json['DirtLevel'] ?? 0,
      healthPoint: json['HealthPoint'] ?? 0,
      userName: json['userName'] ?? '',
      userIcon: json['userIcon'] ?? '',
      bgColors: json['bgColors'] ?? '',
      birthDate: json['BirthDate'] ?? 0,
      livingType: json['livingType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'DirtLevel': dirtLevel,
      'HealthPoint': healthPoint,
      'userName': userName,
      'userIcon': userIcon,
      'bgColors': bgColors,
      'birthDate': birthDate,
      'livingType': livingType,
    };
  }
}
