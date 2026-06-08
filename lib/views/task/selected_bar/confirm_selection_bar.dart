import 'package:authbase_mobile/components/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ConfirmSelectionBar extends StatelessWidget {
  final VoidCallback onDeselect;  // 選択解除処理
  final VoidCallback onConfirm;   // 選択確定処理

  const ConfirmSelectionBar({
    super.key,
    required this.onDeselect,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(223, 230, 222, 1),
        border: Border.all(width: 2, color: AppColors.edgew),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 14,
          color: AppColors.edgew,
          fontFamily: 'textFont',
          fontWeight: FontWeight.w600,
        ),

        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 24,
                        width: 24,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 219, 77, 1),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 4,
                            color: Color.fromRGBO(255, 219, 77, 1),
                          ),
                        ),
                        child: SizedBox(
                          child: Image.asset(
                            height: 20,
                            width: 20,
                            'images/task/check.webp',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text("選択中"),
                    ],
                  ),
                  Text("終了済みは除外されています", style: TextStyle(fontSize: 10)),
                ],
              ),

              SizedBox(width: 4),

              GestureDetector(
                onTap: onDeselect,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.edgew, width: 1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text('選択を解除'),
                ),
              ),

              SizedBox(width: 8),

              GestureDetector(
                onTap: onConfirm,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 219, 77, 1),
                  ),
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
                      padding: EdgeInsets.symmetric(vertical: 2),
                      alignment: Alignment.center,
                      child: GestureDetector(
                        child: Text('選択を確定する ＞'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
