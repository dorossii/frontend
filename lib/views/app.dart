import 'package:authbase_mobile/models/task_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/views/login/login_screen.dart';
import '/views/top/top_screen.dart';
import '/views/task/task_screen.dart';
import 'friend/friend_list/friend_screen.dart';
import '/views/setting/setting_screen.dart';

import '/services/auth_manager.dart';

import '../components/widgets/app_header.dart';
import '../components/widgets/app_footer.dart';

import '../components/extensions/user_view_model.dart';

enum PageType { top, task, friend, setting }

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
        return TaskScreen(
          taskInfo: TaskInfo(taskId: '', userId: '', taskName: '', tags: 0, difficultyLevel: 0, status: 0, startDate: '', endTime: '', imageId: '', advice: ''),
          onTabSelected: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        );
      case PageType.friend:
        return FriendListScreen(
          onTabSelected: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        );
      case PageType.setting:
        return SettingScreen(
          // ログアウト処理
          onLogoutPressed: () async {
            // トークン削除
            await AuthManager.logout();

            // contextがまだ有効か確認
            if (!context.mounted) return;

            // ログイン画面へ戻る
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel()..initialize(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
          appBar: AppHeader(currentPage: _currentPage),

          // 中身だけ変わる
          body: _getScreen(),

          bottomNavigationBar: AppFooter(
            currentPage: _currentPage,
            onTap: (page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
        ),
      ),
    );
  }
}
