import 'package:url_launcher/url_launcher.dart';
import 'package:authbase_mobile/constants/app_config.dart';

/// ログインの状態と処理を管理するクラス
class LoginViewModel {
  bool isLoading = false;

  /// ログイン処理
  Future<bool> login() async {
    if (isLoading) return false; // 二重実行防止

    isLoading = true;

    try {
      // google認証するリンク
      final url = Uri.parse('${AppConfig.baseUrl}/auth/login?ismobile=1');

      final launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      return launched;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}