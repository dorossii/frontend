import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import 'models/user_info.dart';
import 'views/login/login_screen.dart';
import 'package:authbase_mobile/screens/home_screen.dart';
import 'package:authbase_mobile/services/deep_link_service.dart';
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

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _sub;

  final deepLinkService = DeepLinkService();

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// ディープリンク監視
  void _initDeepLinks() async {
    _appLinks = AppLinks();

    // 起動時リンク
    final initial = await _appLinks.getInitialLink();
    if (initial != null) {
      _handleLink(initial);
    }

    // 通常リンク
    _sub = _appLinks.uriLinkStream.listen((uri) {
      if (uri != null) _handleLink(uri);
    });
  }

  /// リンク受け取った時
  Future<void> _handleLink(Uri uri) async {
    if (uri.scheme != 'authbase') return;

    final token = uri.queryParameters['bridge_token'];
    if (token == null) return;

    final context = navigatorKey.currentContext;
    if (context == null) return;

    // ローディング表示
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final userInfo = await deepLinkService.handleBridgeToken(token);

    // ダイアログ閉じる
    if (Navigator.canPop(context)) Navigator.pop(context);

    if (userInfo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ログイン失敗')),
      );
      return;
    }

    // Homeへ
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          userInfo: userInfo,
          onLogout: () async {
            await AuthManager.logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
            );
          },
        ),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: AuthManager.getRefreshToken(),
        builder: (context, snapshot) {

          
      if (snapshot.data != null) {
  return FutureBuilder<UserInfo?>(
    future: AuthManager.getCurrentUserInfo(),
    builder: (context, snapshot) {

      // ローディング
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      // データなし（トークン無効）
      if (!snapshot.hasData) {
        return const LoginScreen();
      }

      final userInfo = snapshot.data!;

      return HomeScreen(
        userInfo: userInfo,
        onLogout: () async {
          await AuthManager.logout();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (_) => false,
          );
        },
      );
    },
  );

          }

          // 未ログイン
          return const LoginScreen();
        },
      ),
    );
  }
}