import 'package:authbase_mobile/components/Colors.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class FriendPictureView extends StatefulWidget {
  // final TaskViewModel viewModel;

  const FriendPictureView({
    super.key,
    // required this.viewModel
  });

  @override
  State<FriendPictureView> createState() => _FriendPictureView();
}

class _FriendPictureView extends State<FriendPictureView> {
  @override
  void initState() {
    super.initState();

    // widget.viewModel.initialize(() {
    //   // API取得後UI更新
    //   setState(() {});
    // });
  }

  // 完了したタスクの写真を撮る画面
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.subWhiteBackground),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Stack(
              clipBehavior: Clip.none, // はみ出ても切れないようにする
              children: [
                Container(
                  width: 320,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: AppColors.subWhiteBackground,
                  ),
                  child: Text("皿洗いをする", style: TextStyle(fontSize: 20)),
                ),
                Positioned(
                  top: -20,
                  left: -20,
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(color: AppColors.subBackground),
                      child: DottedBorder(
                        color: AppColors.subWhiteBackground,
                        strokeWidth: 1.5,
                        dashPattern: [4, 3],
                        customPath: (size) {
                          return Path()
                            // 上線
                            ..moveTo(0, 0)
                            ..lineTo(size.width, 0)
                            // 下線
                            ..moveTo(0, size.height)
                            ..lineTo(size.width, size.height);
                        },
                        child: Container(
                          // padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            child: Text(
                              'Task  Check',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 28, bottom: 16),
            child: Text("ごろちゃんのタスクを確認しよう！", style: TextStyle(fontSize: 18)),
          ),
          Container(
            height: 415,
            width: 361,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.subBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),

            // 写真部分
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.subWhiteBackground,
              ),
              child: Image.asset(
                'images/task/test_picture.png',
                fit: BoxFit.fill,
              ),
            ),

          ),
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
                    //ToDo:モーダル開く処理
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
                Container(
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
              ],
            ),
          ),
          Text(
            "フレンドのタスクの完了処理を行います。",
            style: TextStyle(color: AppColors.darkEdgey.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }

  Future<void> _buildShowDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.subWhiteBackground,
              borderRadius: BorderRadius.circular(5)
            ),
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "なぜ、できていないと感じましたか？",
                  style: TextStyle(fontSize: 16, fontFamily: 'textFont',),
                ),
                SizedBox(
                  // 入力欄横幅
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
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
                          alignment:  Alignment.center,
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
                      Container(
                        alignment:  Alignment.center,
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
