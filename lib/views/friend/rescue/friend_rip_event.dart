import 'package:flutter/material.dart';

import '../../../components/Colors.dart';
import '../../../components/extensions/life_state_layout.dart';
import '../../../components/widgets/app_footer.dart';
import '../../../components/widgets/app_header.dart';
import '../../../components/widgets/character/character_layer.dart';
import '../../app.dart';
import '../../component/animation/typing/typing_text.dart';
import '../../component/home/bottom_view.dart';
import '../../friend/friend_home/friend_view_model.dart';

class FriendRipEvent extends StatelessWidget {
  final FriendHomeViewModel viewModel;
  final Function(PageType) onTabSelected;

  const FriendRipEvent({
    super.key,
    required this.viewModel,
    required this.onTabSelected,
  });
  @override
  Widget build(BuildContext context) {
    final theme = viewModel.currentState.theme;
    final friend = viewModel.friendInfo;
    return Scaffold(
      appBar: AppHeader(currentPage: PageType.friend),
      extendBody: false,
      extendBodyBehindAppBar: false,
      bottomNavigationBar: AppFooter(
        currentPage: null,
        onTap: (page) {
          Navigator.pop(context);
          if (page != PageType.friend) {
            onTabSelected(page);
          }
        },
      ),
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned(
            top: 100.0, 
            left: 0,
            right: 0,
            child: Center(
              child: TypingText(
                friendName: friend.userName,
                onFinished: () {
                  print("タイピング終了");
                },
              ),
            ),
          ),

          CharacterLayer(theme: theme),
          BottomView(),
        ],
      ),
    );
  }
}
