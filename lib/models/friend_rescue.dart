// レスキューが必要なフレンドのモデル
class RescueFriend {
  final String id;
  final String name;  
  final String icon;
  final String background;
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