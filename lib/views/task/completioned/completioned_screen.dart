import 'package:authbase_mobile/components/Colors.dart';
import 'package:authbase_mobile/components/widgets/app_header.dart';
import 'package:authbase_mobile/models/task_info.dart';
import 'package:authbase_mobile/views/app.dart';
import 'package:authbase_mobile/views/task/completioned/completiones_view_model.dart';
import 'package:authbase_mobile/views/task/completioned/take_picture_view.dart';
import 'package:authbase_mobile/views/task/completioned/friend_picture_view.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CompletionedScreen extends StatelessWidget {
  // final TaskInfo taskInfo;
  // final Function(PageType) onTabSelected;

  const CompletionedScreen({
    super.key,
    // required this.taskInfo,
    // required this.onTabSelected,
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
          // TakePictureView(),
          FriendPictureView(),
      ),
    );
  }
}
