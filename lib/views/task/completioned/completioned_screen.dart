import 'package:authbase_mobile/components/Colors.dart';
import 'package:authbase_mobile/components/widgets/app_header.dart';
import 'package:authbase_mobile/models/friend_info.dart';
import 'package:authbase_mobile/models/task_info.dart';
import 'package:authbase_mobile/models/user_status.dart';
import 'package:authbase_mobile/services/user/user_service.dart';
import 'package:authbase_mobile/views/app.dart';
import 'package:authbase_mobile/views/splash/task/splash_screen.dart';
import 'package:authbase_mobile/views/task/completioned/create_message_view.dart';
import 'package:authbase_mobile/views/task/completioned/friend_message_view.dart';
import 'package:authbase_mobile/views/task/completioned/friend_picture_view.dart';
import 'package:authbase_mobile/views/task/completioned/take_picture_view.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:flutter/material.dart';

// タスク確定後に表示させる画面
class CompletionedScreen extends StatelessWidget {
  final TaskViewModel viewModel;
  final String checkTaskId;
  final Map<String, dynamic> checkTask;
  final bool firstTime; // 承認待ちタスクを表示する最初の処理かを判定する変数

  const CompletionedScreen({
    super.key,
    required this.viewModel,
    required this.checkTaskId,
    required this.checkTask,
    required this.firstTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(currentPage: PageType.task),
      body: DefaultTextStyle(
        style: TextStyle(fontFamily: 'textFont', color: AppColors.darkEdgey),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return FutureBuilder<(TaskInfo, FriendInfo)?>(
      future: viewModel.getFriendPicture(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('エラーが発生しました'));
        }

        // 承認待ちタスク確認画面
        if (firstTime) {
          if (snapshot.data != null) {
            return FriendPictureView(
              viewModel: viewModel,
              checkTask: checkTask,
              checkTaskId: checkTaskId,
            );
          }
        }

        // isChangeで写真撮影かメッセージ送信かを分岐
        if (checkTask['isChanged']) {
          // あおりメッセージ送信画面
          if (checkTask['messageUserId'] != '') {
            return FutureBuilder<UserStatus>(
              future: UserService().fetchUserStatus(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (userSnapshot.hasError) {
                  return const Center(child: Text('ユーザー情報の取得に失敗しました'));
                }

                final user = userSnapshot.data!;

                // ユーザーIDであおりメッセージ画面分岐
                if (checkTask['messageUserId'] == user.userId) {
                  // あおりメッセージ送信画面(未来の自分)
                  return CreateMessageView(
                    viewModel: viewModel,
                    userStatus: user,
                  );
                } else {
                  // あおりメッセージ送信画面(フレンド)
                  return FutureBuilder<FriendInfo>(
                    future: viewModel.findFriend(checkTask['messageUserId']),
                    builder: (context, snapshot) {
                      // 読み込み中
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // エラー
                      if (snapshot.hasError) {
                        debugPrint('フレンド取得エラー: ${snapshot.error}');
                        return const Center(child: Text('フレンド情報の取得に失敗しました'));
                      }

                      // データがない
                      if (!snapshot.hasData) {
                        return const Center(child: Text('フレンド情報が見つかりません'));
                      }

                      return FriendMessageView(
                        viewModel: viewModel,
                        friendData: snapshot.data!,
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            );
          }
        } else {
          // 写真撮影画面
          return TakePictureView(
            viewModel: viewModel,
            selectedTaskId: checkTaskId,
          );
        }

        // スプラッシュ画面
        // ToDO: ゴミを投げつける対象を取得して名前を表示
        return TaskAnimationScreen(labelText: "ゴミを回収しています");
      },
    );
  }
}
