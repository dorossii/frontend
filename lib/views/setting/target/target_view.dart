import 'package:flutter/material.dart';
import '../../../components/widgets/app_header.dart';
import '../../app.dart';
import './target_view_model.dart';
import 'package:authbase_mobile/components/colors.dart';
import '../../../models/friend_info.dart';

class TargetListView extends StatefulWidget {
  final TargetListViewModel viewModel;

  const TargetListView({super.key, required this.viewModel});

  @override
  State<TargetListView> createState() => _TargetListViewState();
}

class _TargetListViewState extends State<TargetListView> {
  @override
  void initState() {
    super.initState();

    widget.viewModel.initialize(() {
      if (!mounted) return;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    const darkTextColor = Color(0xFF1E3A34);
    return Scaffold(
      appBar: AppHeader(currentPage: PageType.setting),
      backgroundColor: AppColors.subWhiteBackground,

      body: Column(
        children: [
          // 左上の戻るボタンエリア
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 8, bottom: 4),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: darkTextColor,
                  size: 28,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          // 検索バー
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 20,
              right: 20,
              bottom: 4,
            ),
            child: SizedBox(
              height: 40,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    widget.viewModel.searchFriend(value);
                  });
                },

                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.text,
                  fontFamily: 'textFont',
                ),

                decoration: InputDecoration(
                  hintText: '検索',

                  hintStyle: const TextStyle(
                    fontSize: 20,
                    color: AppColors.text,
                    fontFamily: 'textFont',
                  ),

                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.text,
                    size: 20,
                  ),

                  filled: true,

                  fillColor: AppColors.grayBackground,

                  isDense: true,

                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          // フレンド一覧
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              itemCount: widget.viewModel.filteredFriendList.length,

              itemBuilder: (context, index) {
                final user = widget.viewModel.filteredFriendList[index];

                return _buildFriendItem(context, user);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(BuildContext context, FriendInfo friend) {
    String dirtLevelImage;

    if (friend.dirtLevel > 5) {
      dirtLevelImage = 'images/status/zombieIcon.png';
    } else if (friend.dirtLevel > 3) {
      dirtLevelImage = 'images/status/human2Icon.png';
    } else if (friend.dirtLevel > 0) {
      dirtLevelImage = 'images/status/humanIcon.png';
    } else {
      dirtLevelImage = 'images/status/godIcon.png';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
      ),

      child: Row(
        children: [
          // アイコン
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 30,

                backgroundImage: AssetImage(
                  'images/icons/${friend.iconName}.png',
                ),

                backgroundColor: AppColors.getBackgroundColor(
                  friend.background,
                ),
              ),

              Positioned(
                right: -10,
                bottom: -10,

                child: ClipOval(
                  child: Image.asset(
                    dirtLevelImage,
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 15),

          // 名前・HP
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  friend.userName,

                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "textFont",
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                HpBar(value: friend.healthPoint / 1000),
              ],
            ),
          ),

          const SizedBox(width: 15),

          // 嫌がらせ対象チェック
          _buildActionButton(context, friend),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, FriendInfo friend) {
    final isTarget = widget.viewModel.isTarget(friend.userId);

    return GestureDetector(
      onTap: () async {
        await widget.viewModel.updateTargetInfo(friend.userId);

        if (mounted) {
          setState(() {});
        }
      },

      child: Container(
        width: 40,
        height: 40,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          color: isTarget ? AppColors.btnBackground : AppColors.grayBackground,
        ),

        child: isTarget
            ? const Icon(Icons.check, color: Colors.white, size: 24)
            : null,
      ),
    );
  }
}

class HpBar extends StatelessWidget {
  const HpBar({super.key, required this.value, this.height = 12});

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    final gradient = value <= 0.4
        ? const LinearGradient(colors: [Color(0xFFD53B2A), Color(0xFFFFDB4D)])
        : const LinearGradient(colors: [Color(0xFFFEE590), Color(0xFF55A871)]);

    return Row(
      children: [
        const Text(
          'HP ',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 12,
            fontFamily: 'textFont',
          ),
        ),

        Expanded(
          child: Container(
            height: height,

            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(height / 2),
            ),

            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,

              widthFactor: value.clamp(0, 1),

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),

                decoration: BoxDecoration(
                  gradient: gradient,

                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
