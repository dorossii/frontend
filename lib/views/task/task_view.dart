import 'package:authbase_mobile/services/task/task_service.dart';
import 'package:authbase_mobile/views/app.dart';
import 'package:flutter/material.dart';
import 'task_view_model.dart';
import '../../components/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import '../task/task_view_model.dart';
import 'task_view_model.dart';

class TaskView extends StatefulWidget {
  final TaskViewModel viewModel;

  const TaskView({super.key, required this.viewModel, required Function(PageType) onTabSelected});

  @override
  _TaskView createState() => _TaskView();
}

class _TaskView extends State<TaskView>  {
  @override
  void initState() {
    super.initState();

    widget.viewModel.initialize(() {
      // API取得後UI更新
      setState(() {});
    });
  }

  int selectedTabIndex = 100;  // 選択されているタブのインデックス
  int selectSortIndex = 0;     // 選択されている並び替えのインデックス
  int selectedCount = 0;       // 選択されているアイテムの数
  bool allItemSelected = false;  // まとめて選択がされているか判定する変数
  int tabHeight = 36;           // タブの高さ

  // タブの配列
  static const category = [
    "掃除", "洗濯", "料理", "ゴミ捨て"
  ];
  int allTabIndex = 100;      // すべてのタブを選択する際のindex

  // 並び替えの配列
  static const sortCategorys = [
     "タイトル順", "期限順", "ポイント順"
  ];

// テストデータ -----------------------------------
  List<Map<String, dynamic >> taskItems = [
    {"taskId": "task_001","tags": 0, "taskName": "皿洗いをする", "difficultyLevel": 2, "limitTime": "15:30:30", "advice": "綺麗に洗おうね", "status": 0, "selected": false},
    {"taskId": "task_002","tags": 1, "taskName": "使わなくなった服を捨てる", "difficultyLevel": 5, "limitTime": "15:30:37", "advice": "断捨離断捨離ぃーー！！", "status": 1, "selected": false},
    {"taskId": "task_003","tags": 2, "taskName": "洗濯物をまわす", "difficultyLevel": 4, "limitTime": "16:30:30", "advice": "ぐーるぐる", "status": 2, "selected": false},
    {"taskId": "task_004","tags": 4, "taskName": "洗濯物をまわす", "difficultyLevel": 4, "limitTime": "15:00:30", "advice": "ぐーるぐる", "status": 0, "selected": false},
    {"taskId": "task_005","tags": 3, "taskName": "洗濯物をまわす", "difficultyLevel": 5, "limitTime": "8:30:30", "advice": "ぐーるぐる", "status": 0, "selected": false},
  ];
// ----------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.subWhiteBackground,
      body: DefaultTextStyle(
        style: TextStyle(
          fontFamily: 'textFont',
        ),
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
                      border: Border.all(
                        color: AppColors.edgew,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: _buildTaskList(),
                  ),
              
                  // タブ
                  Positioned(
                    left: 0,
                    right: 0,
                    child: _buildTabButton(),
                  ),
                ],
              ),
            ),
            
            if (allItemSelected || selectedCount != 0)
            _buildConfirmSelection(),

          ]
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
              style: TextStyle(
                fontSize: 10,
                color: AppColors.edgew,
              ),
        
              // 並び替え欄
              child: Row(
                children: [
                  Text(
                    "並び替え："
                  ),
                  ...List.generate(sortCategorys.length, (index){
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectSortIndex = index;
                          if(index == selectSortIndex) widget.viewModel.handleSort(taskItems, selectSortIndex);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          sortCategorys[index],
                          style: TextStyle(
                            color: selectSortIndex == index ? AppColors.subWhiteBackground : AppColors.edgew
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
                padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                margin: EdgeInsets.only(
                  top: 8,
                  left: 12,
                  bottom: 8
                ),
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
                      if(!allItemSelected)selectedCount = 0;
                      widget.viewModel.handleAllSelect(taskItems, allItemSelected, selectedTabIndex, allTabIndex);
                  });
                  },
                  child: Text(
                    "まとめて選択",
                    style: TextStyle(color: Colors.white)
                    ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: taskItems.asMap().entries
                  .where((entry) {
                    // 「すべて」のとき
                    if (selectedTabIndex == allTabIndex) {
                      return true;
                    }
                    // カテゴリーごとの表示
                    return entry.value["tags"] == selectedTabIndex;
                  })
                  .map((entry) {
                    final index = entry.key;
                    final task = entry.value;
          
                    return _buildListItem(task, index);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // リストのアイテム
  Widget _buildListItem(Map<String, dynamic> task, int index) {
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
          color: task["status"] == 2 ? AppColors.edgew.withOpacity(0.3) : AppColors.edgew,
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
                    widget.viewModel.handleUpdateStatus(task);
                    task["selected"]? selectedCount++ : selectedCount-- ;
                  });
                },
                child: Container(
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    // color: AppColors.subWhiteBackground,
                    color: task["selected"]?Color.fromRGBO(255, 219, 77, 1) : AppColors.subWhiteBackground,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 4,
                      color: task["selected"]?Color.fromRGBO(255, 219, 77, 1) : AppColors.subWhiteBackground,
                    )
                  ),
                  child: task["status"] == 1 || task["status"] == 2 || task["selected"]
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
                            task["taskName"],
                            style: TextStyle(
                              fontSize: 14
                            ),
                          ),
                  
                          if (task["status"] == 2)
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
                                  for (int i = 0; i < (task["difficultyLevel"] as int); i++)
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
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    ),
                                    Text(
                                      task["limitTime"],
                                      style: TextStyle(
                                        fontSize: 10
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (task["status"] == 2)
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
              if(task["status"] == 1) _buildApprovalView(), 
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
            child: SizedBox(
              width: 1,
              height: double.infinity,
            ),
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
                ? tabHeight.toDouble() + 2  // 線の太さ分、高さを伸ばして被せる(線を見えないようにする)
                : tabHeight.toDouble() - 2, // 線の太さ分、高さを縮めて下の要素の線に被らないようにする
              width: 64,
              decoration: BoxDecoration(
                color: selectedTabIndex == allTabIndex ? AppColors.subBackground : AppColors.subWhiteBackground,
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: AppColors.edgew,
                  ),
                  left: BorderSide(
                    width: 2,
                    color: AppColors.edgew,
                  ),
                  right: BorderSide(
                    width: 2,
                    color: AppColors.edgew,
                  ),
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(3),
                ),
                
              ),
              child: Center(
                child: Text(
                  "すべて",
                  style: TextStyle(
                    color: AppColors.text,
                  ),
                ),
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
                ? tabHeight.toDouble() + 2  // 線の太さ分、高さを伸ばして被せる(線を見えないようにする)
                : tabHeight.toDouble() - 2, // 線の太さ分、高さを縮めて下の要素の線に被らないようにする
              width: 64,
              decoration: BoxDecoration(
                color: selectedTabIndex == index ? AppColors.subBackground : AppColors.subWhiteBackground,
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: AppColors.edgew,
                  ),
                  left: BorderSide(
                    width: 2,
                    color: AppColors.edgew,
                  ),
                  right: BorderSide(
                    width: 2,
                    color: AppColors.edgew,
                  ),
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(3),
                ),
                
              ),
              child: Center(
                child: Text(
                  category[index],
                  style: TextStyle(
                    color: AppColors.text,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  

  // 選択中のアイテム数を表示
  Widget _buildConfirmSelection() {
    return Positioned(
        bottom: 8,
        left: 12,
        right: 12,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(223, 230, 222, 1),
            border: Border.all(
              width: 2,
              color: AppColors.edgew,
            ),
            borderRadius: BorderRadius.circular(5)
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 12,
              color: AppColors.edgew,
              fontFamily: 'textFont',
              fontWeight: FontWeight.w600,
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 219, 77, 1),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 4,
                                color: Color.fromRGBO(255, 219, 77, 1),
                              )
                            ),
                            child: 
                            SizedBox(
                                child: Image.asset(
                                  height: 20,
                                    width: 20,
                                  'images/task/check.webp',
                                  fit: BoxFit.contain,
                                ),
                              )
                          ),
                          Text(
                            "選択中",
                          ),
                        ]
                      ),
                      Text(
                        "終了済みは除外されています",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.edgew,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      '選択を解除',
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      /// タスク更新
                      await TaskService().updateTaskStatus(
                        taskId: 3,
                        status: 'complete',
                      );
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 219, 77, 1),
                      ),
                      child: DottedBorder(
                        color: AppColors.subWhiteBackground,
                        strokeWidth: 1.5,
                        dashPattern: [4, 3],
                        customPath: (size) {
                          return Path()
                            // 上線
                            ..moveTo(0, 0)
                            ..lineTo(size.width, 0)
                      
                            // 下線
                            ..moveTo(0, size.height)
                            ..lineTo(size.width, size.height);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          child: Text(
                            '選択を確定する ＞',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  // 未完
  void _showModalBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('おはよう'),
                Text('こんにちは'),
                Text('こんばんは'),
              ],
            ),
          ),
        );
      },
    );
  }
}