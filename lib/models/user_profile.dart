class UserProfile {
  final String userName;
  final String birthday;
  final String icon;
  final String background;

  UserProfile({
    required this.userName,
    this.birthday = '',
    required this.icon,
    required this.background,
  });

  // GETなどで取得したJSONから変換
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userName: json['userName'] ?? '',
      birthday: json['birthday'] ?? '',
      icon: json['icon'] ?? '',
      background: json['background'] ?? 'icon1',
    );
  }

  // PUT送信用のJSONデータ（※ birthdayは含めない）
  Map<String, dynamic> toUpdateJson() {
    return {
      'userName': userName,
      'icon': icon,
      'background': background,
    };
  }
}