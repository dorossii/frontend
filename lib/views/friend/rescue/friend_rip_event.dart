import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/Colors.dart';
import '../../../components/extensions/life_state_layout.dart';
import '../../../components/extensions/user_view_model.dart';
import '../../../components/widgets/app_footer.dart';
import '../../../components/widgets/app_header.dart';
import '../../../components/widgets/character/character_layer.dart';
import '../../app.dart';
import '../../component/animation/typing/typing_text.dart';
import '../../component/home/bottom_view.dart';
import '../../friend/friend_home/friend_view_model.dart';
import '../video/call_screen.dart';

class FriendRipEvent extends StatefulWidget {
  final FriendHomeViewModel viewModel;
  final Function(PageType) onTabSelected;

  const FriendRipEvent({
    super.key,
    required this.viewModel,
    required this.onTabSelected,
  });

  @override
  State<FriendRipEvent> createState() => _FriendRipEventState();
}

class _FriendRipEventState extends State<FriendRipEvent> {
  
  bool _showButtons = false;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UserViewModel>();
    final theme = widget.viewModel.currentState.theme;
    final friend = widget.viewModel.friendInfo;

    return Scaffold(
      appBar: AppHeader(currentPage: PageType.friend),
      bottomNavigationBar: AppFooter(
        currentPage: null,
        onTap: (page) {
          Navigator.pop(context);
          if (page != PageType.friend) {
            widget.onTabSelected(page);
          }
        },
      ),
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: TypingText(
                friendName: friend.userName,
                onFinished: () {
                  setState(() {
                    _showButtons = true;
                  });
                },
              ),
            ),
          ),

          CharacterLayer(theme: theme),

          BottomView(
            description: widget.viewModel.currentState.theme.description,
            healthPoint: widget.viewModel.friendInfo.healthPoint,
          ),

          if (_showButtons)
            Positioned(
              bottom: 330,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: 260,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CallScreen(
                              roomName: "test-room",
                              participantName: vm.userStatus?.userName ?? "User",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.videocam,
                        color: AppColors.subWhiteBackground,
                      ),
                      label: const Text(
                        "ビデオ通話をかける",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "textFont",
                          color: AppColors.subWhiteBackground,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.background,
                        foregroundColor: AppColors.subWhiteBackground,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(
                            color: AppColors.subWhiteBackground,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "戻る",
                      style: TextStyle(
                        color: AppColors.subWhiteBackground,
                        fontSize: 16,
                        fontFamily: "textFont",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
