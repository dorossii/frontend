import 'package:flutter/material.dart';
import '../../../components/colors.dart';
import '../../../models/user_profile.dart';
import '../../../services/user/userProfile_service.dart';

class ProfileEditViewModel extends ChangeNotifier {
  final UserProfileService _userProfileService = UserProfileService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Colorから "icon1" 等の文字列キーへのマッピング
  static final Map<Color, String> _colorToKeyMap = {
    AppColors.icon1: 'icon1',
    AppColors.icon2: 'icon2',
    AppColors.icon3: 'icon3',
    AppColors.icon4: 'icon4',
    AppColors.icon5: 'icon5',
    AppColors.icon6: 'icon6',
    AppColors.icon7: 'icon7',
    AppColors.icon8: 'icon8',
  };

  /// パスからアイコン名（ファイル名から拡張子を除いたもの）を抽出するヘルパー関数
  /// 例: 'images/icons/tissue.png' -> 'tissue'
  String _extractIconName(String iconPath) {
    final fileName = iconPath.split('/').last; // 'tissue.png'
    return fileName.split('.').first; // 'tissue'
  }

  /// 保存処理
  Future<bool> saveProfile({
    required String name,
    required String iconPath,
    required Color bgColor,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Colorからキー文字列を取得（例: 'icon1'）
    final bgKey = _colorToKeyMap[bgColor] ?? 'icon1';

    // パスからアイコン名だけを抽出（例: 'tissue'）
    final iconName = _extractIconName(iconPath);

    final profile = UserProfile(
      userName: name,
      icon: iconName, // 'tissue' などの名前をセット
      background: bgKey,
    );

    final success = await _userProfileService.updateProfile(profile);

    _isLoading = false;
    notifyListeners();

    return success;
  }
}
