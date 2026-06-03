import 'package:authbase_mobile/models/task_info.dart';
import 'package:flutter/rendering.dart';

class TaskViewModel {
  final TaskInfo taskInfo;

  TaskViewModel({required this.taskInfo});

  // 並び替え処理 --------------------
  void handleSort(List<Map<String, dynamic>> taskItems, int selectSortIndex) {
    // 名前順
    if (selectSortIndex == 0) {
      taskItems.sort((b, a) => a["taskName"].compareTo(b["taskName"]));
    }

    // 期限順
    if (selectSortIndex == 1) {
      taskItems.sort((a, b) {
        Duration durationA = parseDuration(a["limitTime"]);
        Duration durationB = parseDuration(b["limitTime"]);

        return durationA.compareTo(durationB);
      });
    }

    // 難易度順
    if (selectSortIndex == 2) {
      taskItems.sort(
        (b, a) => a["difficultyLevel"].compareTo(b["difficultyLevel"]),
      );
    }
  }

  // 時間を数値に変換する処理
  Duration parseDuration(String time) {
    final parts = time.split(':');

    return Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(parts[2]),
    );
  }

  // まとめて選択の処理 -------------------
  int handleAllSelect(
    List<Map<String, dynamic>> taskItems,
    bool allItemSelected,
    int selectedTabIndex,
    int allTabIndex,
    int selectedContent,
  ) {
    int count = 0;

    for (final item in taskItems) {
      if (item["status"] != 0) continue;

      // 選択中のステータスをtrueにする
      if (selectedTabIndex == allTabIndex || item["tags"] == selectedTabIndex) {
        item["selected"] = allItemSelected;

        // まとめて選択をしている時に選択アイテム数を格納
        if (allItemSelected) {
          count++;
        }
      }
    }

    return count;
  }

  int handleDeselect(
    List<Map<String, dynamic>> taskItems,
    bool allItemSelected,
    selectedCount,
  ) {
    int count = selectedCount;

    allItemSelected = false;
    taskItems.forEach((item) {
      item["selected"] = false;
      count = 0;
    });

    return count;
  }

  // ステータスを変化する処理 -------------------
  void handleUpdateStatus(task) {
    // 選択中と選択件数を更新する処理
    if (task["status"] == 0) {
      if (task["selected"]) {
        task["selected"] = false;
      } else {
        task["selected"] = true;
      }
    }
    // if(task["status"] == 1){
    //   task["selected"] = false;
    // }
    // if(task["status"] == 0 || task["status"] == 1) {
    //   task["status"] = 2;
    // } else {
    //   task["status"] = 0;
    // }
  }

  void initialize(Null Function() param0) {}
}
