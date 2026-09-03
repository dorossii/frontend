class AppConfig {
  static const String authDomain = 'dorossii.mattuu.com/';
  static String get baseUrl => 'https://$authDomain';

  static const String loginEndpoint = '/auth/login';
  static const String meEndpoint = '/auth/me';
  static const String tokenEndpoint = '/auth/token';
  static const String appEndpoint = '/app/authed';
  static const String taskListEndpoint = '/app/user/task';

  // 初回ユーザー登録
  static const String userRegisterEndpoint = '/app/user/register';
  // 生活環境情報の登録（初回）
  static const String userLifestyleEndpoint = '/app/user/lifestyle';
  // ログの取得
  static const String activityLogEndpoint = '/app/notice';
  // トップ画面ユーザーステータスの取得
  static const String topStatusEndpoint = '/app/user/status';
  // フレンドリストの取得
  static const String friendListEndpoint = '/app/friend';
  // レスキューが必要なフレンドの取得
  static const String rescueFriendListEndpoint = '/app/friend/rescue';
  // レスキューが必要なフレンドの登録
  static const String registerRescueFriendEndpoint = '/app/friend/rescue';
  // 嫌がらせ対象の取得
  static const String targetListEndpoint = '/app/friend/attack';
  // 設定画面のユーザー情報
  static const String userProfileEndpoint = '/app/user/setting';
}

// モックのAPIレスポンスを定義
class MockApiResponse {
  static const String mockDomain = 'mock-dorossii.mattuu.com';
  static const String baseUrl = 'https://$mockDomain';
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
