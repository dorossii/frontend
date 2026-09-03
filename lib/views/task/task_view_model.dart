import 'dart:math';
import 'package:authbase_mobile/models/friend_info.dart';
import 'package:authbase_mobile/models/task_info.dart';
import 'package:authbase_mobile/services/friend/friend_service.dart';
import 'package:authbase_mobile/services/task/task_service.dart';
import 'package:flutter/material.dart';
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

  /// task_view ------------------------------

  // 並び替え処理
  void handleSort(List<TaskInfo> taskItems, int selectSortIndex) {
    // 名前順
    if (selectSortIndex == 0) {
      taskItems.sort((b, a) => a.taskName.compareTo(b.taskName));
    }

    // 期限順
    if (selectSortIndex == 1) {
      taskItems.sort((a, b) => a.endTime.compareTo(b.endTime));
    }

    // 難易度順
    if (selectSortIndex == 2) {
      taskItems.sort((b, a) => a.level.compareTo(b.level));
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

  /// まとめて選択の処理
  /// selectedTabIndex：選択されているタグ
  /// taskSelectedBool：選択状態を管理するリスト
  /// taskList：タスクリスト
  /// updateSelectedCount：選択されたタスクの数
  void handleSelectAll(
    int selectedTabIndex,
    List<bool> taskSelectedBool,
    List<TaskInfo> taskList,
    Function(int) updateSelectedCount,
  ) {
    int count = 0;

    //　すべてのタグの場合
    if (selectedTabIndex == 100) {
      for (int i = 0; i < taskSelectedBool.length; i++) {
        // 未完了＆選択が選択済でない場合
        if (taskList[i].status == 0 && !taskSelectedBool[i]) {
          taskSelectedBool[i] = true;
          count++;
        }
      }
    } else {
      for (int i = 0; i < taskSelectedBool.length; i++) {
        if (taskList[i].tag == selectedTabIndex) {
          if (taskList[i].status == 0 && !taskSelectedBool[i]) {
            taskSelectedBool[i] = true;
            count++;
          }
        }
      }
    }

    updateSelectedCount(count);
  }

  // 選択解除
  void handleDeselect(List<bool> taskSelectedBool) {
    for (int i = 0; i < taskSelectedBool.length; i++) {
      taskSelectedBool[i] = false;
    }
  }

  // 時間を取得
  String handleGetLimit(int endTime) {
    // 秒単位で現在時間を取得する(Unixタイムスタンプ)
    final int nowTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    int limitNum = endTime - nowTime;

    int day = limitNum ~/ (60 * 60 * 24);
    int hour = limitNum % (60 * 60 * 24) ~/ (60 * 60);
    int min = limitNum % (60 * 60 * 24) % (60 * 60) ~/ 60;

    String limitTime = "";

    // コメント部分：時間を最大二つ表示
    if (day > 0) {
      limitTime += "${day.toString()}日";
      // limitTime += "${hour.toString()}時間";
    } else if (hour > 0) {
      limitTime += "${hour.toString()}時間";
      // limitTime += "${min.toString()}分";
    } else {
      limitTime += "${min.toString()}分";
    }

    return limitTime;
  }

  // 選択されたタスクを選択済みor選択解除する
  void handleUpdateStatus(task, index, taskSelectedBool) {
    // 0: 未完了
    // 1: 承認待ち
    // 2: 完了

    // 選択中と選択件数を更新する処理
    if (task.status == 0) {
      if (taskSelectedBool[index]) {
        taskSelectedBool[index] = false;
      } else {
        taskSelectedBool[index] = true;
      }
    }
    if (task.status == 1 || task.status == 2) {
      taskSelectedBool[index] = false;
    }
  }

  /// タスクを更新する処理 ------------------------------

  // タスク更新(完了/未完了)
  Future<(Map<String, dynamic>, String)> handleUpdateTask(
    List<String> selectedTaskId, // 選択されているタスクのリスト
    String message,
    TaskViewModel viewModel,
  ) async {
    Map<String, dynamic> res = {}; // 結果を格納する変数
    Map<String, dynamic> target = {}; // データを一つづつ格納する変数
    List<String> updateTaskId = []; // 完了する対象タスクのリスト
    Map<String, dynamic> checkTask = {};  // タスク完了時にチェックするタスクを格納する変数
    String checkTaskId = "";  // タスク完了時にチェックするタスクIDを格納する変数

    if (selectedTaskId.isNotEmpty) {
      updateTaskId = selectedTaskId;

      // タスク更新のPUT処理
      res = await TaskService().updateTaskStatus(
        selectedTaskId: updateTaskId,
        message: message,
      );

      if(selectedTaskId.length == 1) {  
        // 単体の場合
        checkTask = res;
        checkTaskId = updateTaskId.first;
      } else {
        // 複数の場合、一件ランダムに選んで格納
        int randam = randamNum(0, res.length - 1);

        checkTask = res[randam];
        checkTaskId = res[randam].id;
      }

    } else {
      debugPrint('❌ 選択されたタスクIDが見つかりません');
    }

    return (checkTask, checkTaskId);
  }

  // ランダムに値を出力する処理
  int randamNum(int min, int max) {
    final random = Random();
    // 最小値 min、最大値 max の場合 (最大値を含む)
    int rangeValue = min + random.nextInt(max - min + 1);

    return rangeValue;
  }

  // ランダムに選んだフレンド情報を取得する処理
  Future<FriendInfo> findFriend() async {
    List<FriendInfo> friendList = await FriendService().fetchFriendInfo();
    if (friendList.isEmpty) {
      throw Exception('フレンドが登録されていません');
    }
    int random = randamNum(0, friendList.length - 1);
    return friendList[random];
  }

  // フレンドの承認待ちのタスクを取得し、ランダムに一つ表示する処理
  Future<(TaskInfo, FriendInfo)?> getFriendPicture() async {
    final pendingData = await _service.getFriendPending();
    // for (final task in pendingData) {
    //   debugPrint('承認待ちタスク一覧：　taskId: ${task.taskId}, userId: ${task.userId}, taskName: ${task.taskName}');
    // }

    if (pendingData.isEmpty) {
      // debugPrint("承認待ちタスクがありません");
      return null;
    }

    final friendList = await FriendService().fetchFriendInfo();
    int random = randamNum(0, pendingData.length - 1);
    // フレンドを取得
    FriendInfo selectrdFrien = friendList.firstWhere(
      (f) => f.userId == pendingData[random].userId,
    );

    return (pendingData[random], selectrdFrien);
  }
}
