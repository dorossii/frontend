class RescueFriend {
  final String id;
  final String name;
  final String icon;
  final String background;
  final bool isRescued; // レスキュー状態フラグ

  RescueFriend({
    required this.id,
    required this.name,
    required this.icon,
    required this.background,
    this.isRescued = false,
  });

  factory RescueFriend.fromJson(Map<String, dynamic> json) {
    return RescueFriend(
      // APIの user_id または id に対応
      id: (json['user_id'] ?? json['id'])?.toString() ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      background: json['background'] ?? '',
      isRescued: json['isrescued'] ?? false, 
    );
  }
}