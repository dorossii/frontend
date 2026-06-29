import 'package:flutter/material.dart';
import 'package:authbase_mobile/components/colors.dart';
import 'package:provider/provider.dart';
import '../extensions/life_state_layout.dart';
import '../../../components/extensions/dirtLevelIcon.dart';
import '../extensions/user_view_model.dart';


class HeaderView extends StatelessWidget implements PreferredSizeWidget {
  final bool isTop;

  const HeaderView({super.key, this.isTop = false});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final vm = context.watch<UserViewModel>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6), // 影の色と透明度
            blurRadius: 8, // 影のぼかし具合
            offset: const Offset(0, 3), // 下方向に3pxずらす
          ),
        ],
      ),
      padding: EdgeInsets.only(top: topPadding),
      // isTop が true ならログ、false ならステータスを表示
      child: isTop ? _buildLogHeader() : _buildMyStatusHeader(vm, context),
    );
  }

  // トップ画面用：ログ表示
  Widget _buildLogHeader() {
    // 表示したいログの配列
    final List<String> logs = [
      "2025/04/19 ごろちゃんにゴミを投げつけられました。",
      "2025/04/19 ごろちゃんにゴミを投げつけられました。",
      "2025/04/19 ごろちゃんにゴミを投げつけられました。",
      "2025/04/19 ごろちゃんにゴミを投げつけられました。",
      "2025/04/19 ごろちゃんにゴミを投げつけられました。",
    ];

    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF9EABA4),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.darkEdgey, width: 1),
      ),
      child: Scrollbar(
        thickness: 2,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          itemCount: logs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Text(
                logs[index],
                style: const TextStyle(fontSize: 10, fontFamily: 'textFont'),
              ),
            );
          },
        ),
      ),
    );
  }

  // 通常画面用：マイステータス
  Widget _buildMyStatusHeader(UserViewModel vm, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Image.asset(
              (vm.dirtLevel).statusIcon,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HP: ${((vm.hp)).floor()}/100",
                  style: const TextStyle(
                    color: AppColors.subWhiteBackground,
                    fontSize: 10,
                    fontFamily: 'textFont',
                  ),
                ),
                Text(
                  vm.userName,
                  style: const TextStyle(
                    color: AppColors.subWhiteBackground,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'textFont',
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "汚さレベル",
                style: TextStyle(
                  color: AppColors.subWhiteBackground,
                  fontSize: 8,
                  fontFamily: 'textFont',
                ),
              ),
              Text(
                vm.currentState.theme.description,
                style: const TextStyle(
                  color: AppColors.subWhiteBackground,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'textFont',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(isTop ? 110 : 75);
}
