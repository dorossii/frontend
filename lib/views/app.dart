import 'package:flutter/material.dart';

import '/views/top/top_screen.dart';
import '/views/task/task_screen.dart';
import '/views/friend/friend_screen.dart';
import '/views/setting/setting_screen.dart';

import '../components/widgets/app_header.dart';
import '../components/widgets/app_footer.dart';


enum PageType {
  top,
  task,
  friend,
  setting,
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  PageType _currentPage = PageType.top;

  /// 画面切り替え
  Widget _getScreen() {
    switch (_currentPage) {
      case PageType.top:
        return const TopScreen();
      case PageType.task:
        return const TaskScreen();
      case PageType.friend:
        return const FriendScreen();
      case PageType.setting:
        return const SettingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const AppHeader(),

        // 中身だけ変わる
        body: _getScreen(),

        // 画面によってfooterの中身が変わるため
        // 状態をもたせる
        bottomNavigationBar: AppFooter(
          currentPage: _currentPage,
          onTap: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
      ),
    );
  }
}