import 'package:flutter/material.dart';
import '../../../../components/colors.dart';


//  タスクのスプラッシュ画面
class TaskSplash1 extends StatelessWidget {
  const TaskSplash1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/task_splash1.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }

}
