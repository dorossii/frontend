class AppConfig {
  static const String authDomain = 'dorossii.mattuu.com/';
  static String get baseUrl => 'https://$authDomain';
  
  static const String loginEndpoint = '/auth/login';
  static const String meEndpoint = '/auth/me';
  static const String tokenEndpoint = '/auth/token';
  static const String appEndpoint = '/app/authed';

  // 初回ユーザー登録
  static const String userRegisterEndpoint = '/app/user/register';
  // 生活環境情報の登録（初回）
  static const String userLifestyleEndpoint = '/app/user/lifestyle';
  // トップ画面ユーザーステータスの取得
  static const String topStatusEndpoint = '/app/user/status';
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
    // タスクリストの取得
    static const String taskListEndpoint = '/app/user/task';
    // レスキューが必要なフレンドの取得
    static const String rescueFriendListEndpoint = '/app/friend/rescue';
    // レスキューが必要なフレンドの登録
    static const String registerRescueFriendEndpoint = '/app/friend/rescue';
}