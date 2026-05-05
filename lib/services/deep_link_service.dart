import 'package:authbase_mobile/services/auth_service.dart';
import 'package:authbase_mobile/services/auth_manager.dart';
import '../models/user_info.dart';

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
      final userInfo = await AuthManager.getCurrentUserInfo();
      if (userInfo == null) return null;

      return userInfo;

    } catch (e) {
      return null;
    }
  }
}