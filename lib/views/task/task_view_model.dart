class TaskViewModel {

  // 並び替え処理 --------------------
  void handleSort(
    List<Map<String, dynamic>> taskItems, 
    int selectSortIndex
  ) {
    // 名前順
    if(selectSortIndex == 0) {
      taskItems.sort(
        (b, a) => a["taskName"].compareTo(b["taskName"]),
      );
    }

    // 期限順
    if(selectSortIndex == 1) {

      taskItems.sort((a, b) {
        Duration durationA = parseDuration(a["limitTime"]);
        Duration durationB = parseDuration(b["limitTime"]);

        return durationA.compareTo(durationB);
      });
    }

    // 難易度順
    if(selectSortIndex == 2) {
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
  void handleAllSelect(
    List<Map<String, dynamic>> taskItems,
    bool allItemSelected,
    selectedTabIndex,
    allTabIndex
  ) {
    if(allItemSelected){
      // 選択を適応
      taskItems.forEach((item) {
        if(selectedTabIndex == allTabIndex) { item["status"] = 2; }  // すべてのタブを選択している時
        else if(item["tags"] == selectedTabIndex) { item["status"] = 2; }}); 
    } else {
      // 選択を解除
      taskItems.forEach((item) {
        if(selectedTabIndex == allTabIndex) { item["status"] = 0; }  // すべてのタブを選択している時
        else if(item["tags"] == selectedTabIndex) { item["status"] = 0; }});
      }
    }


    // ステータスを変化する処理 -------------------
    void handleUpdateStatus (task){
      if(task["status"] == 0 || task["status"] == 1) {
        task["status"] = 2;
      } else {
        task["status"] = 0;
      }
    }
  }
