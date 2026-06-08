import 'package:authbase_mobile/models/task_info.dart';
import 'package:authbase_mobile/services/task/task_service.dart';
import 'package:flutter/rendering.dart';

class TaskViewModel {
  final TaskInfo taskInfo;

  // コンストラクタで受け取る
  TaskViewModel({required this.taskInfo});

  /// API通信クラス
  final TaskService _service = TaskService();

  /// APIから取得したタスク情報
  List<TaskInfo> taskList = [];

  /// ローディング状態
  bool isLoading = false;

  /// 初期化
  Future<void> initialize(void Function() onUpdate) async {
    await fetcTaskInfo(onUpdate);
  }

  /// APIからフレンド情報取得
  Future<void> fetcTaskInfo(void Function() onUpdate) async {
    /// ローディング開始
    isLoading = true;

    /// UI更新
    onUpdate();

    try {
      /// API通信
      taskList = await _service.fetchTaskInfo();

    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    }

    /// ローディング終了
    isLoading = false;

    /// UI更新
    onUpdate();
  }


  // 並び替え処理 --------------------
  void handleSort(taskItems, int selectSortIndex) {
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
  void handleSelectAll(
    List<bool> taskSelectedBool,
    List<TaskInfo> taskList,
    Function(int) updateSelectedCount,
  ) {
    int count = 0;

    for (int i = 0; i < taskSelectedBool.length; i++) {
      if (taskList[i].status == 0 && !taskSelectedBool[i]) {
        taskSelectedBool[i] = true;
        count++;
      }
    }

    updateSelectedCount(count);
  }

  // 選択解除
  void handleDeselect(
    List<bool> taskSelectedBool
  ) {
    for (int i = 0; i < taskSelectedBool.length; i++) {
      taskSelectedBool[i] = false;
    }
  }

  // 時間を取得
  String handleGetLimit(int endTime) {

    // 秒単位で現在時間を取得する(Unixタイムスタンプ)
    final int nowTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    print("📌nowTime: $nowTime");

    
    int limitNum = endTime - nowTime;
    // int limitNum = nowTime - endTime;

    print("🔋limitNum: $limitNum");

    int day = limitNum ~/ (60 * 60 * 24);
    int hour = limitNum % (60 * 60 * 24) ~/ (60 * 60);
    int min = limitNum % (60 * 60 * 24) % (60 * 60) ~/ 60;

    String limitTime = "";

    // 時間を全部表示
    // if(day > 0) {
    //   limitTime += "${day.toString()}日";
    // }
    // if(hour > 0) {
    //   limitTime += "${hour.toString()}時間";
    // }
    // if(min > 0) {
    //   limitTime += "${min.toString()}分";
    // }

    // コメント部分：時間を最大二つ表示
    if(day > 0) {
      limitTime += "${day.toString()}日";
      // limitTime += "${hour.toString()}時間";
    } else if(hour > 0) {
      limitTime += "${hour.toString()}時間";
      // limitTime += "${min.toString()}分";
    } else {
      limitTime += "${min.toString()}分";
    }

    return limitTime;
  }

  // ステータスを変化する処理 -------------------
  void handleUpdateStatus(task, index, taskSelectedBool) {
    // 選択中と選択件数を更新する処理
    if (task.status == 0) {
      if (taskSelectedBool[index]) {
        taskSelectedBool[index] = false;
      } else {
        taskSelectedBool[index] = true;
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
}
