/// 初回ユーザー登録のリクエスト情報
class UserRegisterRequest {
  /// 誕生日（UNIXタイムスタンプ）
  final int birthDate;

  /// 居住形態（例: alone, family など）
  final String livingType;

  UserRegisterRequest({
    required this.birthDate,
    required this.livingType,
  });

  Map<String, dynamic> toJson() {
    return {
      'birthDate': birthDate,
      'livingType': livingType,
    };
  }
}

/// 初回ユーザー登録のレスポンス情報
class UserRegisterResponse {
  final String userId;
  final String userName;
  final int birthDate;
  final String livingType;

  UserRegisterResponse({
    required this.userId,
    required this.userName,
    required this.birthDate,
    required this.livingType,
  });

  /// JSON → UserRegisterResponse
  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) {
    return UserRegisterResponse(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      birthDate: json['birthDate'] ?? 0,
      livingType: json['livingType'] ?? '',
    );
  }
}
