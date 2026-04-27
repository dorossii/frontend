class AppConfig {
  static const String authDomain = 'dorossii.mattuu.com/';
  static String get baseUrl => 'https://$authDomain';
  
  static const String loginEndpoint = '/auth/login';
  static const String meEndpoint = '/auth/me';
  static const String tokenEndpoint = '/auth/token';
  static const String appEndpoint = '/app/authed';
}
