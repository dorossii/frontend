import 'package:flutter/material.dart';
import 'package:authbase_mobile/components/colors.dart';
import '../../component/home/bottom_view.dart';
import 'friend_view_model.dart';
// ヘッダーフッター表示のために、PageTypeをインポート
import '../../../components/widgets/app_header.dart';
import '../../../components/widgets/app_footer.dart';
import '../../app.dart';

import '../../../components/extensions/life_state_layout.dart';
import '../../../components/widgets/character/character_layer.dart';
import '../../../components/widgets/trashs/trash_layer.dart';
import '../../../components/extensions/trash_layer_type.dart';

class FriendHomeView extends StatelessWidget {
  final FriendHomeViewModel viewModel;
  final Function(PageType) onTabSelected;

  const FriendHomeView({
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
            left: 16,
            right: 16,

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
                        Image.asset(
                          'images/home/back.png',
                          width: 42,
                          height: 42,
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          '戻る',

                          style: TextStyle(
                            color: AppColors.subWhiteBackground,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'textFont',
                          ),
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

                      border: Border.all(
                        color: const Color(0xFF2D1E16),
                        width: 3,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(4, 4),
                        ),
                      ],
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
