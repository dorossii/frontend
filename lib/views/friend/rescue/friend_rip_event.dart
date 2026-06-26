import 'package:flutter/material.dart';

import '../../../components/Colors.dart';
import '../../../components/extensions/life_state_layout.dart';
import '../../../components/models/status.dart';
import '../../../components/widgets/character/character_layer.dart';

class FriendRipEvent extends StatelessWidget {
  const FriendRipEvent({super.key});

  @override
  Widget build(BuildContext context) {
    // ripイベントのテーマを取得
    final theme = LifeState.rip.theme;
    return Stack(
      children: [
        Container(color: AppColors.black), // 背景色を黒に設定
        // キャラクター画像
        CharacterLayer(theme: theme),
      ],
    );
  }
}
