import 'package:authbase_mobile/components/Colors.dart';
import 'package:authbase_mobile/components/widgets/app_header.dart';
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
        return FriendPictureView(viewModel: viewModel,);
      case 3:
        return CreateMessageView();
      case 4:
        return FriendMessageView(viewModel: viewModel);
      default:
      return SizedBox();
    }
  }
}
