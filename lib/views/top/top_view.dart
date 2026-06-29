import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:authbase_mobile/components/colors.dart';
import '../../components/extensions/life_state_layout.dart';
import '../../components/extensions/trash_layer_type.dart';
import '../../components/extensions/user_view_model.dart';
import '../../components/widgets/character/character_layer.dart';
import '../component/home/bottom_view.dart';
import '../../components/widgets/trashs/trash_layer.dart';

class TopView extends StatelessWidget {
  const TopView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UserViewModel>();

    final theme = vm.currentState.theme;

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
                BottomView(
                  description: vm.currentState.theme.description,
                  healthPoint: vm.userStatus?.healthPoint ?? 0,
                ),
              ],
            ),
    );
  }
}
