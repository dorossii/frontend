import 'package:authbase_mobile/components/colors.dart';
import 'package:authbase_mobile/services/task/task_service.dart';
import 'package:authbase_mobile/views/splash/task/splash_screen.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

// メッセージ送信デザインのコンポーネント
class CreateMessageDesign extends StatelessWidget {
  final TaskViewModel viewModel;
  final TextEditingController controller;
  final String labelText;
  final String sendUserId;

  const CreateMessageDesign({
    super.key,
    required this.viewModel,
    required this.controller,
    required this.labelText,
    required this.sendUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.subWhiteBackground),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none, // はみ出ても切れないようにする
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20),
                child: Text(labelText, style: TextStyle(fontSize: 16)),
              ),
              Positioned(
                top: -20,
                left: 10,
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
                            'Mission',
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
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 24, bottom: 16, left: 40),
            child: Text(
              "例：早くタスクしなー！！\nしんどい時は休憩もだいじだよ！",
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(
            width: 320,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(bottom: 2),
                  child: Text("32文字以内", style: TextStyle(fontSize: 12)),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: controller,
                    inputFormatters: [
                      // 最大8文字まで入力可能
                      LengthLimitingTextInputFormatter(32),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      hintText: "頑張って！！",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "アプリが自動でタイミングを決めて通知します",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkEdgey.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                SizedBox(height: 180),
                GestureDetector(
                  onTap: () {
                    if (controller.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "文章を入力してください。");
                    } else {
                      TaskService().sendMessage(
                        sendUserId: sendUserId,
                        message: controller.text,
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                      );
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 128,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      "確定",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.subWhiteBackground,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    "タスクの完了処理を行います。",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkEdgey.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
