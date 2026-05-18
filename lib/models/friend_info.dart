// フレンドのステータスを表すモデルクラス
class FriendInfo {
  final String background; // カラー指定
  final int dirtLevel; // 汚さレベル
  final int healthPoint; // HP
  final String iconName; // アイコン
  final String userName; // 名前
  final String userId; // ユーザーID

  FriendInfo({
    required this.background,
    required this.dirtLevel,
    required this.healthPoint,
    required this.iconName,
    required this.userName,
    required this.userId,
    
  });

  /// JSON → FriendInfo
  factory FriendInfo.fromJson(Map<String, dynamic> json) {
    return FriendInfo(
      background: json['background'] ?? '',
      dirtLevel: json['dirtLevel'] ?? 0,
      healthPoint: json['hp'] ?? 0,
      iconName: json['icon'] ?? '',
      userName: json['name'] ?? '',
      userId: json['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'background': background,
      'dirtLevel': dirtLevel,
      'hp': healthPoint,
      'icon': iconName,
      'name': userName,
      'user_id': userId,
    };
  }
}
