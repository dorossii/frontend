// ユーザーステータスを表すモデルクラス
class UserStatus {
  final String userId; // ユーザーID
  final int dirtLevel; // 汚さレベル
  final int healthPoint; // HP
  final String userName; // 名前

  UserStatus({
    required this.userId,
    required this.dirtLevel,
    required this.healthPoint,
    required this.userName,
  });

  /// JSON → UserInfo
  factory UserStatus.fromJson(Map<String, dynamic> json) {
    return UserStatus(
      userId: json['userId'] ?? '',
      dirtLevel: json['DirtLevel'] ?? 0,
      healthPoint: json['HealthPoint'] ?? 0,
      userName: json['userName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'DirtLevel': dirtLevel,
      'HealthPoint': healthPoint,
      'userName': userName,
    };
  }
}
