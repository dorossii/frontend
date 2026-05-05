/// ユーザー情報モデル
class UserInfo {
  final String userId;
  final String name;
  final String email;
  final String provCode;
  final String provUid;

  UserInfo({
    required this.userId,
    required this.name,
    required this.email,
    required this.provCode,
    required this.provUid,
  });

  /// JSON → UserInfo
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      provCode: json['prov_code'] ?? '',
      provUid: json['prov_uid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'prov_code': provCode,
      'prov_uid': provUid,
    };
  }
}