import 'package:authbase_mobile/services/auth_service.dart';
import 'package:authbase_mobile/services/auth_manager.dart';

/// ディープリンクの「中身処理」だけ担当
class DeepLinkService {

  /// bridgeTokenを受け取ってログイン処理する
  Future<UserInfo?> handleBridgeToken(String bridgeToken) async {
    try {
      // ① bridgeToken → refreshToken に交換
      final refreshToken =
          await AuthService().exchangeBridgeToken(bridgeToken);

      if (refreshToken == null) return null;

      // ② 保存
      await AuthManager.saveRefreshToken(refreshToken);

      // ③ ユーザー情報取得
      final userInfoMap = await AuthManager.getCurrentUserInfo();
      if (userInfoMap == null) return null;

      return UserInfo.fromJson(userInfoMap);

    } catch (e) {
      return null;
    }
  }
}