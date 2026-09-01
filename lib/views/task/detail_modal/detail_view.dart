import 'dart:math';

import 'package:authbase_mobile/components/colors.dart';
import 'package:authbase_mobile/models/task_info.dart';
import 'package:authbase_mobile/views/task/detail_modal/detail_modal.dart';
import 'package:authbase_mobile/views/task/detail_modal/underlineText.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:flutter/material.dart';

class DetailModalView extends StatelessWidget {
  final TaskViewModel viewModel;
  final TaskInfo task;
  final VoidCallback onUpDate;

  const DetailModalView({
    super.key,
    required this.viewModel,
    required this.task,
    required this.onUpDate,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          child: Container(
            width: double.infinity,
            color: AppColors.subWhiteBackground,
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.darkBackground,
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 閉じるボタン
                            Padding(
                              padding: const EdgeInsets.only(top: 16, left: 16),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 42,
                                  width: 42,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0, 3),
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: Image.asset(
                                        'images/task/closeBtn.webp',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // 写真
                            Center(
                              child: Container(
                                height: 135,
                                width: 274,
                                decoration: BoxDecoration(
                                  color: AppColors.gray,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: (task.imageId != null)
                                    ? Image.network(
                                        'https://mock-dorossii.mattuu.com/app/user/task/${task.imageId}/image',
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: Text(
                                          "画像がありません",
                                          style: TextStyle(
                                            fontFamily: 'textFont',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 32),
                          ],
                        ),
                        Positioned(
                          top: 72,
                          right: 40,
                          child: Transform.rotate(
                            angle: 90 * pi / -50,
                            child: Container(
                              height: 16,
                              width: 72,
                              color: AppColors.subBackground,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 36,
                          left: 40,
                          child: Transform.rotate(
                            angle: 90 * pi / 500,
                            child: Container(
                              height: 16,
                              width: 72,
                              color: AppColors.subBackground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: AppColors.subWhiteBackground,
                    padding: const EdgeInsets.all(10),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "textFont",
                        color: AppColors.text,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.taskName,
                            style: const TextStyle(fontSize: 24),
                          ),

                          const SizedBox(height: 10),

                          // タスク情報
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Image.asset(
                                          height: 20,
                                          width: 20,
                                          'images/task/carender.webp',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Text(handleGetStartDate(task.startDate)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: const [
                                    Expanded(flex: 1, child: SizedBox()),
                                    Expanded(
                                      flex: 4,
                                      child: Divider(
                                        height: 2,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: Center(child: Text("難易度")),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          for (int i = 0; i < task.level; i++)
                                            Image.asset(
                                              height: 20,
                                              width: 20,
                                              'images/task/difficultyLevel_green.webp',
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text("フレンドからのコメント"),

                          const SizedBox(height: 8),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: UnderlineText(text: task.message),
                          ),

                          const SizedBox(height: 32),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: UnderlineText(text: task.description),
                          ),

                          const SizedBox(height: 32),

                          Center(
                            child: ElevatedButton(
                              onPressed: onUpDate,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 5,
                                minimumSize: const Size(300, 50),
                              ),
                              child: Text(
                                'タスク完了！！',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "textFont",
                                  color: AppColors.subWhiteBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
