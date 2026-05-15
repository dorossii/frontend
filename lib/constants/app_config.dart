class AppConfig {
  static const String authDomain = 'dorossii.mattuu.com/';
  static String get baseUrl => 'https://$authDomain';
  
  static const String loginEndpoint = '/auth/login';
  static const String meEndpoint = '/auth/me';
  static const String tokenEndpoint = '/auth/token';
  static const String appEndpoint = '/app/authed';
}

// モックのAPIレスポンスを定義
class MockApiResponse {
    static const String mockDomain = 'mock-dorossii.mattuu.com';
    static const String baseUrl = 'https://$mockDomain';

    // User
    // トップ画面ユーザーステータスの取得
    static const String topStatusEndpoint = '/app/user/status';
    // Friend
    // フレンドリストの取得
    static const String friendListEndpoint = '/app/friend';

}