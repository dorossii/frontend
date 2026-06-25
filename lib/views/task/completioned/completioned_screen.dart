import 'package:authbase_mobile/components/Colors.dart';
import 'package:authbase_mobile/components/widgets/app_header.dart';
import 'package:authbase_mobile/models/friend_info.dart';
import 'package:authbase_mobile/models/user_status.dart';
import 'package:authbase_mobile/services/user/user_service.dart';
import 'package:authbase_mobile/views/app.dart';
import 'package:authbase_mobile/views/task/completioned/create_message_view.dart';
import 'package:authbase_mobile/views/task/completioned/friend_message_view.dart';
import 'package:authbase_mobile/views/task/completioned/friend_picture_view.dart';
import 'package:authbase_mobile/views/task/completioned/take_picture_view.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:flutter/material.dart';

class CompletionedScreen extends StatelessWidget {
  final TaskViewModel viewModel;
  final List<String> selectedTaskId;
  final int confirmType;

  const CompletionedScreen({
    super.key,
    required this.viewModel,
    required this.selectedTaskId,
    required this.confirmType,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(currentPage: PageType.task),
      body: DefaultTextStyle(
        style: TextStyle(
          fontFamily: 'textFont',
          color: AppColors.darkEdgey,
        ),
        child: 
          _buildContent(confirmType),
      ),
    );
  }

  // ignore: strict_top_level_inference
  Widget _buildContent(confirmType) {

    switch(confirmType) {
      case 1:
        return TakePictureView(viewModel: viewModel, selectedTaskId: selectedTaskId);
      case 2:
        return FriendPictureView(viewModel: viewModel);
      case 3:
        //　未来の自分に向けてメッセージを送る画面
        return FutureBuilder<UserStatus>(
          // ユーザー情報取得
          future: UserService().fetchUserStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text('データの取得に失敗しました'));
            }
            return CreateMessageView(
              viewModel: viewModel,
              userStatus: snapshot.data!,
            );
          }
        );
      case 4:
        return FutureBuilder<FriendInfo>(
          future: viewModel.findFriend(),
          builder: (context, snapshot) {
            // まだデータの取得が終わっていない間は、ローディング画面を表示する
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            return FriendMessageView(
              viewModel: viewModel,
              friendData: snapshot.data!,
            );
          },
        );
      default:
      return SizedBox();
    }
  }
}
