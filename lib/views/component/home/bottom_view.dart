// 友達救済のボタンとステータス表示を含む、ホーム画面の下部に配置されるウィジェット
import 'package:flutter/material.dart';

import '../../../components/Colors.dart';
import '../../../models/friend_rescue.dart';
import '../../../services/friend/friend_rescue_service.dart';
import '../rescue/rescue_view.dart';
import '../rescue/rescue_view_model.dart';
import 'hp_bar.dart';

class BottomView extends StatelessWidget {
  final String description;
  final int healthPoint;
  

  const BottomView({
    super.key,
    required this.description,
    required this.healthPoint,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            left: 16,
            top: 16,
            bottom: 16,
            right: 0,
          ),
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(
              top: BorderSide(color: AppColors.sub, width: 2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextStatusBox("汚さレベル", description),
                    const SizedBox(height: 8),
                    _buildWidgetStatusBox(
                      "HP",
                      HpBar(value: healthPoint / 1000),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _buildRescueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // テキスト専用ステータス
  // =========================
  Widget _buildTextStatusBox(String label, String value) {
    return _buildBaseBox(
      label: label,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'textFont',
          color: AppColors.text,
        ),
      ),
    );
  }

  // =========================
  // Widget専用ステータス
  // =========================
  Widget _buildWidgetStatusBox(String label, Widget child) {
    return _buildBaseBox(
      label: label,
      child: child,
    );
  }

  // =========================
  // 共通UI（土台）
  // =========================
  Widget _buildBaseBox({
    required String label,
    required Widget child,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 28,
                left: 6,
                right: 0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.subBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.edgew,
                    width: 2.5,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 6,
            bottom: 6,
            child: Stack(
              children: [
                // メインボックス
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.subBackground,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        topLeft: Radius.zero,
                      ),
                      border: Border.all(
                        color: AppColors.edgew,
                        width: 2.5,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.subWhiteBackground,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: child,
                    ),
                  ),
                ),

                // ラベル
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.subBackground,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: AppColors.edgew,
                          width: 2.5,
                        ),
                        left: BorderSide(
                          color: AppColors.edgew,
                          width: 2.5,
                        ),
                        right: BorderSide(
                          color: AppColors.edgew,
                          width: 2.5,
                        ),
                      ),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'textFont',
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ),

                // 左の補強線
                Positioned(
                  top: 22,
                  left: 0,
                  child: Container(
                    width: 2.5,
                    height: 5,
                    color: AppColors.edgew,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // 友達救済ボタン
  // =========================
  Widget _buildRescueButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final List<RescueFriend>? selectedUuids =
            await RescueView.showRescueFriendDialog(
          context,
          await RescueViewModel().getFriends(),
        );

        if (selectedUuids == null || selectedUuids.isEmpty) return;
        if (!context.mounted) return;

        try {
          final uuidList =
              selectedUuids.map((f) => f.id.toString()).toList();

          final bool isSuccess =
              await registerRescueFriends(uuidList);

          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isSuccess ? '送信が完了しました！' : '送信に失敗しました',
              ),
            ),
          );
        } catch (e) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('通信エラー: $e')),
          );
        }
      },
      child: SizedBox(
        width: 110,
        height: 120,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 110,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                border: Border.all(
                  color: AppColors.darkEdgey,
                  width: 3,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "友達救済",
                    style: TextStyle(
                      color: AppColors.subWhiteBackground,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'textFont',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "レスキューボタン",
                      style: TextStyle(
                        color: AppColors.subWhiteBackground,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'textFont',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 0,
              child: Image.asset(
                'images/rescue.webp',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}