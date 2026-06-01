// レスキューが必要なフレンドのモデル
class RescueFriend {
  final String id;          // フレンドのID
  final String name;        // フレンドの名前
  final String icon;        // フレンドのアイコンURL
  final String background;  // フレンドの背景URL
  RescueFriend({
    required this.id,
    required this.name,
    required this.icon,
    required this.background,
  });

  factory RescueFriend.fromJson(Map<String, dynamic> json) {
    return RescueFriend(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      background: json['background'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'background': background,
    };
  }
}