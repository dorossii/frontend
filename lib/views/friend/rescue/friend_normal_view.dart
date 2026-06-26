import 'package:flutter/material.dart';
import 'package:authbase_mobile/components/colors.dart';
import '../../component/home/bottom_view.dart';
import '../../friend/friend_home/friend_view_model.dart';
// ヘッダーフッター表示のために、PageTypeをインポート
import '../../../components/widgets/app_header.dart';
import '../../../components/widgets/app_footer.dart';
import '../../app.dart';

import '../../../components/extensions/life_state_layout.dart';
import '../../../components/widgets/character/character_layer.dart';
import '../../../components/widgets/trashs/trash_layer.dart';
import '../../../components/extensions/trash_layer_type.dart';

class FriendNormalHomeView extends StatelessWidget {
  final FriendHomeViewModel viewModel;
  final Function(PageType) onTabSelected;

  const FriendNormalHomeView({
    super.key,
    required this.viewModel,
    required this.onTabSelected,
  });
  @override
  Widget build(BuildContext context) {
    final theme = viewModel.currentState.theme;
    final friend = viewModel.friendInfo;
    return Scaffold(
      backgroundColor: AppColors.background,
      // 共通ヘッダーを配置（Friendタブとして表示）
      appBar: AppHeader(currentPage: PageType.friend),

      bottomNavigationBar: AppFooter(
        currentPage: null,
        onTap: (page) {
          Navigator.pop(context);

          if (page != PageType.friend) {
            onTabSelected(page);
          }
        },
      ),
      body: Stack(
        children: [
          // 背景画像
          Positioned.fill(
            child: Image.asset(theme.background, fit: BoxFit.cover),
          ),

          Positioned(
            top: 20,
            left: 24,
            right: 24,

            child: Stack(
              children: [
                // 左上戻る
                Align(
                  alignment: Alignment.topLeft,

                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        // 画像＋丸背景
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.subWhiteBackground.withOpacity(
                              0.9,
                            ),
                            shape: BoxShape.circle,

                            boxShadow: [
                              BoxShadow(
                                color: AppColors.edgew.withOpacity(0.25),
                                blurRadius: 6,
                                offset: const Offset(2, 3),
                              ),
                            ],
                          ),

                          child: Center(
                            child: Image.asset(
                              'images/home/back.png',
                              width: 28,
                              height: 28,
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        Stack(
                          children: [
                            // 縁（白）
                            Text(
                              '戻る',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'textFont',
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1.5
                                  ..color = AppColors.subWhiteBackground,
                              ),
                            ),

                            // 中（緑）
                            const Text(
                              '戻る',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'textFont',
                                color: AppColors.text, // 緑
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // 真ん中タイトル
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.getBackgroundColor(friend.background),

                      borderRadius: BorderRadius.circular(4),
                    ),

                    child: Text(
                      '${friend.userName} のお家',

                      style: const TextStyle(
                        color: Colors.white,

                        fontSize: 18,

                        fontWeight: FontWeight.bold,

                        fontFamily: 'textFont',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ゴミ
          TrashLayer(theme: theme, layer: TrashLayerType.back),
          // キャラクター画像
          CharacterLayer(theme: theme),
          TrashLayer(theme: theme, layer: TrashLayerType.front),

          // ステータスとボタンのコンテナ
          BottomView(),
        ],
      ),
    );
  }
}
