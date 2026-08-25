import 'package:authbase_mobile/components/colors.dart';
import 'package:flutter/material.dart';

class DetailModalView extends StatelessWidget {
  const DetailModalView({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (
        BuildContext context,
        ScrollController scrollController,
      ) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.darkBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            children: [
              // 閉じるボタン
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: const [
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
              Container(
                height: 135,
                width: 274,
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // スクロール部分
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 32),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.subWhiteBackground,
                    ),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "textFont",
                        color: AppColors.text,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "皿洗いをする",
                            style: TextStyle(fontSize: 24),
                          ),

                          const SizedBox(height: 10),

                          // タスク情報
                          Container(
                            width: double.infinity,
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
                            padding: const EdgeInsets.all(12),
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
                                        children: const [
                                          SizedBox(width: 16),
                                          Text("2026年○月×日(火)"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: const [
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Divider(
                                        height: 2,
                                        thickness: 2,
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
                                      child: Center(
                                        child: Text("難易度"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
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
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              "フレンドからのコメント。"
                              "フレンドからのコメント。"
                              "フレンドからのコメント。",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey,
                                decorationThickness: 1,
                              ),
                            ),
                          ),

                          const SizedBox(height: 300),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}