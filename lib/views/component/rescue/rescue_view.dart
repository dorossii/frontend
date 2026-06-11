import 'package:flutter/material.dart';
import '../../../components/colors.dart';
import '../../../models/friend_rescue.dart';

// レスキューのポップアップを表示するクラス
class RescueView {
  static Future<List<RescueFriend>?> showRescueFriendDialog(
    BuildContext context,
    List<RescueFriend> rescueFriends,
  ) async {
    final selected = <String>{};

    return showDialog<List<RescueFriend>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: AppColors.subWhiteBackground,
              titlePadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.edgew, width: 3),
              ),
              title: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.sub,
                  border: Border(
                    bottom: BorderSide(color: AppColors.edgew, width: 2),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: SizedBox(
                  height: 28,
                  child: Stack(
                    children: [
                      const Center(
                        child: Text(
                          "誰をレスキューしますか？",
                          style: TextStyle(
                            fontFamily: 'textFont',
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4, right: 4),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.text,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Image.asset(
                      'images/chara/zonbi.webp',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 6),

                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: rescueFriends.map((friend) {
                          final isSelected = selected.contains(friend.id);

                          return ListTile(
                            contentPadding: EdgeInsets.zero,

                            leading: Checkbox(
                              value: isSelected,
                              activeColor: AppColors.btnBackground,
                              checkColor: AppColors.subWhiteBackground,

                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selected.add(friend.id);
                                  } else {
                                    selected.remove(friend.id);
                                  }
                                });
                              },
                            ),
                            title: Row(
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundImage: AssetImage(
                                    'images/icons/${friend.icon}.png',
                                  ),
                                  backgroundColor: AppColors.getBackgroundColor(
                                    friend.background,
                                  ),
                                ),

                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    friend.name,
                                    style: const TextStyle(
                                      fontFamily: 'textFont',
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.text,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 45,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sub,

                        foregroundColor: AppColors.text,

                        elevation: 8,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                            color: AppColors.edgew,
                            width: 2,
                          ),
                        ),
                      ),

                      onPressed: () {
                        // 選択された友達のオブジェクト（RescueFriend）のリストを作る
                        final resultList = rescueFriends
                            .where((f) => selected.contains(f.id))
                            .toList();

                        //  元の設計通り、オブジェクトのリストを返して閉じる（これで型エラーが消えます）
                        Navigator.pop(context, resultList);
                      },

                      child: const Text(
                        "レスキュー実行",
                        style: TextStyle(
                          fontFamily: 'textFont',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
