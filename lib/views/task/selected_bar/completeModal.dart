import 'package:authbase_mobile/components/colors.dart';
import 'package:flutter/material.dart';

class CompleteDialog extends StatelessWidget {
  final String title;
  final VoidCallback onUpDate;

  const CompleteDialog({
    super.key,
    required this.title,
    required this.onUpDate,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return DefaultTextStyle(
          style: TextStyle(fontFamily: 'textFont', color: AppColors.text),
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            backgroundColor: AppColors.subWhiteBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: EdgeInsets.only(top: 4),

            title: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'textFont',
                  color: AppColors.text,
                  fontSize: 16,
                ),
              ),
            ),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "タスクを完了しますか？",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'textFont',
                    color: AppColors.text,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),

            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Container(
                  height: 32,
                  width: 104,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.subBackground,
                    borderRadius: BorderRadius.circular(3),
                  ),

                  child: Text(
                    "キャンセル",
                    style: TextStyle(fontFamily: 'textFont', fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 16),
              InkWell(
                onTap: onUpDate,
                child: Container(
                  height: 32,
                  width: 104,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 219, 77, 1),
                    borderRadius: BorderRadius.circular(3),
                  ),

                  child: Text(
                    "完了",
                    style: TextStyle(fontFamily: 'textFont', fontSize: 16),
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
