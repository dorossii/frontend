// ignore_for_file: collection_methods_unrelated_type

import 'dart:async';
import 'package:authbase_mobile/views/app.dart';
import 'package:authbase_mobile/views/task/completioned/completioned_screen.dart';
import 'package:authbase_mobile/views/task/selected_bar/completeModal.dart';
import 'package:flutter/material.dart';
import 'task_view_model.dart';
import '../../components/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'selected_bar/confirm_selection_bar.dart';

class TaskView extends StatefulWidget {
  final TaskViewModel viewModel;

  const TaskView({
    super.key,
    required this.viewModel,
    required Function(PageType) onTabSelected,
  });

  @override
  State<TaskView> createState() => _TaskView();
}

class _TaskView extends State<TaskView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    widget.viewModel.initialize(() {
      // API取得後UI更新
      setState(() {
        if (taskSelectedBool.isEmpty && widget.viewModel.taskList.isNotEmpty) {
          taskSelectedBool = List.filled(
            widget.viewModel.taskList.length,
            false,
          );
        }
      });

      _timer = Timer.periodic(const Duration(minutes: 1), (_) {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int selectedTabIndex = 100; // 選択されているタブのインデックス
  int selectSortIndex = 0; // 選択されている並び替えのインデックス
  int selectedCount = 0; // 選択されているアイテムの数
  bool allItemSelected = false; // まとめて選択がされているか判定する変数
  List<String> selectedTaskId = []; // 選択されたアイテムのID
  int tabHeight = 36; // タブの高さ

  List<bool> taskSelectedBool = [];

  // タブの配列
  static const category = ["掃除", "洗濯", "料理", "ゴミ捨て"];
  int allTabIndex = 100; // すべてのタブを選択する際のindex

  // 並び替えの配列
  static const sortCategorys = ["タイトル順", "期限順", "ポイント順"];

  // ----------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.subWhiteBackground,
      body: DefaultTextStyle(
        style: TextStyle(fontFamily: 'textFont'),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Stack(
                children: [
                  // タブ下のコンテンツ
                  Container(
                    margin: EdgeInsets.only(
                      top: tabHeight.toDouble(), // タブの高さ分だけ下げる
                    ),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.subBackground,
                      border: Border.all(color: AppColors.edgew, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: _buildTaskList(),
                  ),

                  // タブ
                  Positioned(left: 0, right: 0, child: _buildTabButton()),
                ],
              ),
            ),

            // タスク選択時の確認バー
            if (allItemSelected || selectedCount != 0)
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: ConfirmSelectionBar(
                  // 選択解除処理
                  onDeselect: () {
                    setState(() {
                      allItemSelected = false; // まとめて選択を解除
                      selectedCount = 0; // 選択したアイテム数をリセット
                      widget.viewModel.handleDeselect(
                        taskSelectedBool,
                      ); // すべてのタスクの選択解除
                    });
                  },
                  // 選択確定処理
                  onConfirm: () {
                    // 選択したタスクIDを格納する
                    widget.viewModel.taskList.asMap().forEach((
                      int index,
                      task,
                    ) {
                      if (taskSelectedBool[index] == true) {
                        selectedTaskId.add(task.taskId);
                      }
                    });
                    // 確定確認のモーダルを開く
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CompleteDialog(
                          // 一件のみ選択した場合はタスク名を表示
                          title: (selectedTaskId.length == 1)
                              ? widget.viewModel.taskList
                                    .firstWhere(
                                      (task) =>
                                          task.taskId == selectedTaskId[0],
                                    )
                                    .taskName
                              : "まとめて選択",
                          // 完了時の処理
                          onUpDate: () async {
                            // タスク更新処理
                            final data = await widget.viewModel.handleUpdateTask(selectedTaskId, "", widget.viewModel);

                            // 画面遷移
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CompletionedScreen(
                                  viewModel: widget.viewModel,
                                  selectedTaskId: selectedTaskId,
                                  // 写真が必須の場合は1(写真を撮る画面)
                                  confirmType: (selectedTaskId.length == 1)
                                    // 単体
                                    ? (data['requireImage']
                                        ? 1
                                        : widget.viewModel.randamNum(2, 4))
                                    // 複数
                                    : (data[selectedTaskId[
                                            widget.viewModel.randamNum(0, selectedTaskId.length - 1)]]
                                            ['requireImage']
                                        ? 1
                                        : widget.viewModel.randamNum(2, 4)),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 表示するタスク一覧部分
  Widget _buildTaskList() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            DefaultTextStyle(
              style: TextStyle(fontSize: 10, color: AppColors.edgew),

              // 並び替え欄
              child: Row(
                children: [
                  Text("並び替え："),
                  ...List.generate(sortCategorys.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectSortIndex = index;
                          if (index == selectSortIndex) {
                            widget.viewModel.handleSort(
                              widget.viewModel.taskList,
                              selectSortIndex,
                            );
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          sortCategorys[index],
                          style: TextStyle(
                            color: selectSortIndex == index
                                ? AppColors.subWhiteBackground
                                : AppColors.edgew,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                margin: EdgeInsets.only(top: 8, left: 12, bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.edgew,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 3),
                      blurRadius: 5,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                // まとめて選択の処理
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      allItemSelected = !allItemSelected;

                      widget.viewModel.handleSelectAll(
                        selectedTabIndex,
                        taskSelectedBool,
                        widget.viewModel.taskList,
                        (count) => selectedCount += count,
                      );
                    });
                  },
                  child: Text("まとめて選択", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: widget.viewModel.taskList
                      .asMap()
                      .entries
                      .where((entry) {
                        // 「すべて」のとき
                        if (selectedTabIndex == allTabIndex) {
                          return true;
                        }
                        // カテゴリーごとの表示
                        return entry.value.tag == selectedTabIndex;
                      })
                      .map((entry) {
                        final index = entry.key;
                        final task = entry.value;

                        return _buildListItem(task, index);
                      })
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // リストのアイテム
  Widget _buildListItem(task, int index) {
    return InkWell(
      // タスク詳細を表示
      onTap: () async {
        _showModalBottomSheet();
      },

      child: Container(
        width: MediaQuery.of(context).size.width * 4 / 5,
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          // color: AppColors.edgew,
          color: task.status == 2
              ? AppColors.edgew.withOpacity(0.3)
              : AppColors.edgew,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 3),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: AppColors.subWhiteBackground,
            fontFamily: 'textFont',
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.viewModel.handleUpdateStatus(
                      task,
                      index,
                      taskSelectedBool,
                    ); // 選択を確定するボタン表示
                    taskSelectedBool[index] ? selectedCount++ : selectedCount--;
                    if (selectedCount == 0) allItemSelected = false;
                  });
                },
                child: Container(
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    // color: AppColors.subWhiteBackground,
                    color: taskSelectedBool[index]
                        ? Color.fromRGBO(255, 219, 77, 1)
                        : AppColors.subWhiteBackground,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 4,
                      color: taskSelectedBool[index]
                          ? Color.fromRGBO(255, 219, 77, 1)
                          : AppColors.subWhiteBackground,
                    ),
                  ),
                  child:
                      task.status == 1 ||
                          task.status == 2 ||
                          taskSelectedBool[index]
                      ? SizedBox(
                          child: Image.asset(
                            height: 20,
                            width: 20,
                            'images/task/check.webp',
                            fit: BoxFit.contain,
                          ),
                        )
                      : null,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 8, bottom: 4),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Text(
                            task.taskName,
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),

                          if (task.status == 2)
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 10,
                              child: Container(
                                height: 2,
                                color: Colors.black45,
                              ),
                            ),
                        ],
                      ),
                      Stack(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  for (int i = 0; i < (task.level as int); i++)
                                    SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: Image.asset(
                                        'images/task/difficultyLevel.webp',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "残り時間：",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    // ToDO
                                    Text(
                                      widget.viewModel.handleGetLimit(
                                        task.endTime,
                                      ),
                                      // "",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (task.status == 2)
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 10,
                              child: Container(
                                height: 2,
                                color: Colors.black45,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (task.status == 1) _buildApprovalView(),
              if (task.status == 0 && task.message.isEmpty) _buildAgainView(),
            ],
          ),
        ),
      ),
    );
  }

  // 承認待ちのウィジェット
  Widget _buildApprovalView() {
    return IntrinsicHeight(
      child: Row(
        children: [
          DottedBorder(
            color: AppColors.subWhiteBackground,
            strokeWidth: 1.5,
            dashPattern: [4, 3],
            customPath: (size) {
              return Path()
                ..moveTo(0, 0)
                ..lineTo(0, size.height);
            },
            child: SizedBox(width: 1, height: double.infinity),
          ),

          Container(
            margin: EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/task/approvalCamera.webp',
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                ),

                Text(
                  "承認待機中",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(255, 219, 77, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 承認されなかったウィジェット
  Widget _buildAgainView() {
    return IntrinsicHeight(
      child: Row(
        children: [
          DottedBorder(
            color: AppColors.subWhiteBackground,
            strokeWidth: 1.5,
            dashPattern: [4, 3],
            customPath: (size) {
              return Path()
                ..moveTo(0, 0)
                ..lineTo(0, size.height);
            },
            child: SizedBox(width: 1, height: double.infinity),
          ),

          Container(
            margin: EdgeInsets.only(left: 14, right: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/task/againCamera.webp',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                ),

                Text(
                  "もう一度",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(255, 77, 77, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // タブのボタン
  Widget _buildTabButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // "すべて"のタブ
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTabIndex = allTabIndex;
            });
          },
          child: Container(
            height: selectedTabIndex == allTabIndex
                ? tabHeight.toDouble() +
                      2 // 線の太さ分、高さを伸ばして被せる(線を見えないようにする)
                : tabHeight.toDouble() - 2, // 線の太さ分、高さを縮めて下の要素の線に被らないようにする
            width: 64,
            decoration: BoxDecoration(
              color: selectedTabIndex == allTabIndex
                  ? AppColors.subBackground
                  : AppColors.subWhiteBackground,
              border: Border(
                top: BorderSide(width: 2, color: AppColors.edgew),
                left: BorderSide(width: 2, color: AppColors.edgew),
                right: BorderSide(width: 2, color: AppColors.edgew),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
            ),
            child: Center(
              child: Text("すべて", style: TextStyle(color: AppColors.text)),
            ),
          ),
        ),
        // その他のタブ
        ...List.generate(category.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTabIndex = index;
              });
            },
            child: Container(
              height: selectedTabIndex == index
                  ? tabHeight.toDouble() +
                        2 // 線の太さ分、高さを伸ばして被せる(線を見えないようにする)
                  : tabHeight.toDouble() - 2, // 線の太さ分、高さを縮めて下の要素の線に被らないようにする
              width: 64,
              decoration: BoxDecoration(
                color: selectedTabIndex == index
                    ? AppColors.subBackground
                    : AppColors.subWhiteBackground,
                border: Border(
                  top: BorderSide(width: 2, color: AppColors.edgew),
                  left: BorderSide(width: 2, color: AppColors.edgew),
                  right: BorderSide(width: 2, color: AppColors.edgew),
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
              ),
              child: Center(
                child: Text(
                  category[index],
                  style: TextStyle(color: AppColors.text),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // タスク詳細
  void _showModalBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.darkBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                offset: Offset(0, 3),
                                blurRadius: 5,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: Image.asset(
                                'images/task/closeBtn.webp',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: AppColors.subBackground,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 写真
                    Container(
                      height: 135,
                      width: 274,
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}