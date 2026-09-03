// 嫌がらせユーザーの取得
class TargetInfo {
  final String targetUser;

  TargetInfo({required this.targetUser});

  factory TargetInfo.fromJson(Map<String, dynamic> json) {
    return TargetInfo(
      targetUser: json['targetUser'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetUser': targetUser,
    };
  }
}
