// 嫌がらせユーザー
class TargetInfo {
  final String targetUser;

  TargetInfo({required this.targetUser});

  factory TargetInfo.fromJson(Map<String, dynamic> json) {
    return TargetInfo(
      targetUser: json['TargetUser'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TargetUser': targetUser,
    };
  }
}
