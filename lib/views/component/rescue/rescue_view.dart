import 'package:flutter/material.dart';
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
              title: const Text("助けるフレンドを選択"),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: rescueFriends.map((friend) {
                    final isSelected = selected.contains(friend.id);

                    return CheckboxListTile(
                      title: Text(friend.name),
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
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("キャンセル"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final result = rescueFriends
                        .where((f) => selected.contains(f.id))
                        .toList();

                    Navigator.pop(context, result);
                  },
                  child: const Text("決定"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
