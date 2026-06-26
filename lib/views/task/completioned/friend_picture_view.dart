import 'package:authbase_mobile/components/Colors.dart';
import 'package:authbase_mobile/models/friend_info.dart';
import 'package:authbase_mobile/models/task_info.dart';
import 'package:authbase_mobile/views/component/task/take_picture_design.dart';
import 'package:authbase_mobile/views/splash/task/splash_screen.dart';
import 'package:authbase_mobile/services/task/task_service.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:flutter/material.dart';

// 完了したタスクの写真を撮る画面
class FriendPictureView extends StatefulWidget {
  final TaskViewModel viewModel;

  const FriendPictureView({super.key, required this.viewModel});

  @override
  State<FriendPictureView> createState() => _FriendPictureView();
}

class _FriendPictureView extends State<FriendPictureView> {
  late TextEditingController _controller;
  TaskInfo? pendingData;
  FriendInfo? selectedFriend;
  List<String> selectedTaskId = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    widget.viewModel.initialize(() async {
      final (task, friend) = await widget.viewModel.getFriendPicture();

      if (!mounted) return;

      setState(() {
        pendingData = task;
        selectedFriend = friend;
        selectedTaskId = [pendingData!.taskId];
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TakePictureDesign(
      viewModel: widget.viewModel,
      taskName: (pendingData != null) ? pendingData!.taskName : '',
      lavelText: "${selectedFriend?.userName ?? ''}のタスクを確認しよう！",
      imgContainer: _imgContainer,
      buttomBtn: _buttomBtn,
    );
  }

  // 写真を表示する部分
  Widget _imgContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.subWhiteBackground,
      ),
      child: (pendingData != null)
          ? Image.network(
              'https://mock-dorossii.mattuu.com/app/user/task/${pendingData!.imageId}/image',
              fit: BoxFit.cover,
            )
          : SizedBox.shrink(),
    );
  }

  // 完了/未完了 ボタン部分
  Widget _buttomBtn() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text('この写真でタスクが完了しているか判定してください'),
        ),
        Container(
          margin: EdgeInsets.only(top: 24, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _buildShowDialog();
                },
                child: Container(
                  width: 112,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.subBackground,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    "未完了",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.subWhiteBackground,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 48),
              GestureDetector(
                onTap: () {
                  TaskService().updateTaskStatus(
                    selectedTaskId: selectedTaskId,
                    message: "",
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                  );
                },
                child: Container(
                  width: 112,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    "完了",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.subWhiteBackground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          "フレンドのタスクの完了処理を行います。",
          style: TextStyle(color: AppColors.darkEdgey.withValues(alpha: 0.5)),
        ),
      ],
    );
  }

  // ダイアログ
  Future<void> _buildShowDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.subWhiteBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "なぜ、できていないと感じましたか？",
                  style: TextStyle(fontSize: 16, fontFamily: 'textFont'),
                ),
                SizedBox(
                  // 入力欄横幅
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      labelText: 'コメント',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 32,
                          width: 104,
                          decoration: BoxDecoration(
                            color: AppColors.subBackground,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            "キャンセル",
                            style: TextStyle(fontFamily: 'textFont'),
                          ),
                        ),
                      ),
                      SizedBox(width: 32),
                      GestureDetector(
                        onTap: () => {
                          TaskService().sendMessage(
                            sendUserId: selectedFriend!.userId,
                            message: _controller.text,
                          ),
                          // 画面遷移
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SplashScreen(),
                            ),
                          ),
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 32,
                          width: 104,
                          decoration: BoxDecoration(
                            color: AppColors.sub,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            "送信",
                            style: TextStyle(fontFamily: 'textFont'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
