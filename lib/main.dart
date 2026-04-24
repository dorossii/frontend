// main.dart
import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:authbase_mobile/screens/login_screen.dart';
import 'package:authbase_mobile/screens/home_screen.dart';
import 'package:authbase_mobile/services/auth_service.dart';
import 'package:authbase_mobile/services/auth_manager.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  bool _isProcessingLink = false; // 二重処理を防ぐフラグ

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initDeepLinks();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('🔄 App lifecycle state changed: $state');
    // アプリがフォアグラウンドに戻った時のログ
    if (state == AppLifecycleState.resumed) {
      debugPrint('✅ App resumed to foreground');
    }
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was started by a deep link
    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      debugPrint('📱 Initial link: $initialLink');
      if (initialLink != null) {
        _handleLink(initialLink);
      }
    } catch (e) {
      debugPrint('❌ Error getting initial link: $e');
    }

    // Listen for subsequent links
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri? uri) {
        debugPrint('📱 Received link from stream: $uri');
        if (uri != null) {
          _handleLink(uri);
        }
      },
      onError: (err) {
        debugPrint('❌ Error processing deep link: $err');
      },
    );
  }

  Future<void> _handleLink(Uri uri) async {
    debugPrint("🔗 Processing deep link: $uri");
    
    // 二重処理を防ぐ
    if (_isProcessingLink) {
      debugPrint('⚠️ Already processing a link, ignoring this one');
      return;
    }

    // authbaseスキームでbridgetokenがある場合のみ処理
    if (uri.scheme == 'authbase' && uri.queryParameters.containsKey('bridge_token')) {
      _isProcessingLink = true;
      final String bridgeToken = uri.queryParameters['bridge_token']!;
      
      // バリデーション中であることを示すダイアログを表示
      final context = navigatorKey.currentContext;
      if (context != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );
      }

      try {
        // ブリッジトークンをリフレッシュトークンに交換
        final String? refreshToken = await AuthService().exchangeBridgeToken(bridgeToken);
        
        if (!mounted) return;

        // ダイアログを閉じる
        if (navigatorKey.currentContext != null && Navigator.canPop(navigatorKey.currentContext!)) {
          Navigator.pop(navigatorKey.currentContext!);
        }

        if (refreshToken == null) {
          debugPrint("❌ Token exchange failed");
          if (mounted) {
            final ctx = navigatorKey.currentContext;
            if (ctx != null) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('認証トークンの交換に失敗しました')),
              );
            }
          }
          _isProcessingLink = false;
          return;
        }

        // リフレッシュトークンを保存
        await AuthManager.saveRefreshToken(refreshToken);
        debugPrint("💾 Refresh token saved to secure storage");

        // ユーザー情報を取得
        final userInfoMap = await AuthManager.getCurrentUserInfo();
        if (userInfoMap == null) {
          debugPrint("❌ Failed to get user info after exchange");
          _isProcessingLink = false;
          return;
        }
        final userInfo = UserInfo.fromJson(userInfoMap);

        // HomeScreenに遷移
        debugPrint('🏠 Navigating to HomeScreen');
        if (!mounted) return;
        
        final context = navigatorKey.currentContext;
        if (context == null) {
          debugPrint('❌ navigatorKey.currentContext is null!');
          _isProcessingLink = false;
          return;
        }

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              userInfo: userInfo,
              onLogout: () async {
                await AuthManager.logout();
                if (!context.mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ),
          (route) => false,
        );
        debugPrint('✅ Navigation command executed.');

      } catch (e) {
        debugPrint("❌ Error during link processing: $e");
        if (mounted && navigatorKey.currentContext != null && Navigator.canPop(navigatorKey.currentContext!)) {
          Navigator.pop(navigatorKey.currentContext!);
        }
        _isProcessingLink = false;
      } finally {
        // 処理終了後にフラグをリセット
        _isProcessingLink = false;
      }
    } else {
      debugPrint('⚠️ Link does not match authbase scheme or missing bridgetoken');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Authbase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
        future: AuthManager.getRefreshToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          
          final refreshToken = snapshot.data;
          if (refreshToken != null) {
            return FutureBuilder<Map<String, dynamic>?>(
              future: AuthManager.getCurrentUserInfo(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                
                final userInfoMap = userSnapshot.data;
                if (userInfoMap != null) {
                  final userInfo = UserInfo.fromJson(userInfoMap);
                  return HomeScreen(
                    userInfo: userInfo,
                    onLogout: () async {
                      await AuthManager.logout();
                      if (!context.mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  );
                } else {
                  // 無効なトークンは削除
                  AuthManager.logout();
                  return const LoginScreen();
                }
              },
            );
          }
          
          return const LoginScreen();
        },
      ),
    );
  }
}
