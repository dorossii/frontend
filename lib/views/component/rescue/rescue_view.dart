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
                borderRadius: BorderRadius.circular(16),
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
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "誰をレスキューしますか？",
                        style: TextStyle(
                          fontFamily: 'textFont',
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.close, color: AppColors.text),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: rescueFriends.map((friend) {
                    final isSelected = selected.contains(friend.id);

                    return ListTile(
                      contentPadding: EdgeInsets.zero,

                      leading: Checkbox(
                        value: isSelected,
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
                            radius: 20,
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
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    final result = rescueFriends
                        .where((f) => selected.contains(f.id))
                        .toList();

                    Navigator.pop(context, result);
                  },
                  child: const Text(
                    "レスキュー実行",
                    style: TextStyle(
                      fontFamily: 'textFont',
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                      fontSize: 14,
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
