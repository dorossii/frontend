import 'package:authbase_mobile/components/Colors.dart';
import 'package:authbase_mobile/views/app.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class TakePictureDesign extends StatelessWidget {
  final TaskViewModel viewModel;
  final String taskName;
  final String lavelText;
  final buttomBtn;
  final String pageType;    // user or friend
  final String imagePath;
  
  const TakePictureDesign({
    super.key,
    required this.viewModel,
    required this.taskName,
    required this.lavelText,
    required this.buttomBtn,
    required this.pageType,
    required this.imagePath,
  });

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
                  child: Text(
                    taskName,
                     style: TextStyle(fontSize: 20)
                    ),
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
            child: Text(lavelText, style: TextStyle(fontSize: 18)),
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
            child: pageType == "user"
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.subWhiteBackground,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.subWhiteBackground,
                  ),
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.fill,
                  ),
                )
          ),
          buttomBtn(),
        ],
      ),
    );
  }
}