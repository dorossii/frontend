import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:authbase_mobile/components/colors.dart';
import '../../components/extensions/life_state_layout.dart';
import '../../components/extensions/trash_layer_type.dart';
import '../../components/extensions/user_view_model.dart';
import '../../components/widgets/character/character_layer.dart';
import '../component/rescue/rescue_view.dart';
import '../../components/widgets/trashs/trash_layer.dart';
import '../component/rescue/rescue_view_model.dart';

class TopView extends StatelessWidget {
  const TopView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UserViewModel>();

    final theme = vm.currentState.theme;
    final user = vm.userStatus;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // 背景画像
                Positioned.fill(
                  child: Image.asset(theme.background, fit: BoxFit.cover),
                ),

                // キャラの後ろのゴミ
                TrashLayer(theme: theme, layer: TrashLayerType.back),

                // キャラクター
                CharacterLayer(theme: theme),

                // キャラの前のゴミ
                TrashLayer(theme: theme, layer: TrashLayerType.front),

                // ステータスとボタンのコンテナ
                Align(
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
                                _buildStatusBox("汚さレベル", theme.description),
                                const SizedBox(height: 8),
                                _buildStatusBox(
                                  "HP",
                                  "${((user?.healthPoint ?? 0) / 10).floor()}/100",
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
                ),
              ],
            ),
    );
  }

  // 重複を削除し、1つにまとめたステータスボックス生成関数 （ラベルと値を引数で受け取る）
  Widget _buildStatusBox(String label, String value) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Stack(
        children: [
          // 後ろ側の図形（影パーツ）
          Positioned.fill(
            child: Padding(
              // メインのカードのサイズと揃える
              padding: const EdgeInsets.only(
                top: 28,
                left: 6,
                bottom: 0,
                right: 0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.subBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.edgew, width: 2.5),
                  // 影の追加
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

          // 手前のメインカード（ラベル一体型）
          Positioned(
            top: 0,
            left: 0,
            right: 6,
            bottom: 6,
            child: _buildCardShape(label: label, value: value),
          ),
        ],
      ),
    );
  }

  // 手前のカード専用：ラベルとボックスを一体化させる描画
  Widget _buildCardShape({required String label, required String value}) {
    final baseColor = AppColors.subBackground;
    final borderColor = AppColors.edgew;

    return Stack(
      children: [
        // メインボックス
        Padding(
          padding: const EdgeInsets.only(top: 18), // ラベルの高さ分を確保
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
                // 左上を直角にしてラベルと馴染ませる
                topLeft: Radius.zero,
              ),
              border: Border.all(color: borderColor, width: 2.5),
            ),
            padding: const EdgeInsets.all(4), // 緑の縁取りの太さ
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.subWhiteBackground, // 内側の白いエリア
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'textFont',
                  color: AppColors.text,
                ),
              ),
            ),
          ),
        ),

        // ラベル部分（ボックスの上に重ねて、下の線を隠す）
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
              border: Border(
                top: BorderSide(color: borderColor, width: 2.5),
                left: BorderSide(color: borderColor, width: 2.5),
                right: BorderSide(color: borderColor, width: 2.5),
                bottom: BorderSide.none, // 下の線を消してボックスと繋げる
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
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
        ),

        // 繋ぎ目の「左の縦線」を補強
        Positioned(
          top: 22,
          left: 0,
          child: Container(width: 2.5, height: 5, color: borderColor),
        ),
      ],
    );
  }

  // 友達救済ボタンのウィジェット
  Widget _buildRescueButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final friends = await RescueViewModel().getFriends();

        final selected = await RescueView.showRescueFriendDialog(
          context,
          friends,
        );

        if (selected != null) {
          print(selected);
        }
      },

      child: SizedBox(
        width: 110,
        height: 120,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // 背面の土台カード
            Container(
              width: 110,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                border: Border.all(color: AppColors.darkEdgey, width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "友達救済",
                    style: TextStyle(
                      color: AppColors.subWhiteBackground,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'textFont',
                    ),
                  ),
                  const Padding(
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

            // はみ出すボタン画像
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
