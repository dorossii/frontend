class AppConfig {
  static const String authDomain = 'desktop-p9h6p2a.saury-wage.ts.net';
  static String get baseUrl => 'https://$authDomain';
  
  static const String loginEndpoint = '/auth/login';
  static const String meEndpoint = '/auth/me';
  static const String tokenEndpoint = '/auth/token';
  static const String appEndpoint = '/app/authed';
}
