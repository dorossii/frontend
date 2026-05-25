// タスクのステータスを表すモデルクラス
class TaskInfo {
  final String taskId;        // タスクID
  final String userId;        // ユーザーID
  final String taskName;      // タスクのタイトル
  final int status;           // ステータス
  final int tags;             // 掃除カテゴリーのタグ
  final int difficultyLevel;  // 難易度
  final String startDate;     // 開始時間
  final String endTime;       // 終了時間
  final String imageId;       // 詳細画像
  final String advice;        // アドバイス

  TaskInfo({
    required this.taskId,
    required this.userId,
    required this.taskName,
    required this.tags,
    required this.difficultyLevel,
    required this.status,
    required this.startDate,
    required this.endTime,
    required this.imageId,
    required this.advice,
  });

  factory TaskInfo.fromJson(Map<String, dynamic> json) {
    return TaskInfo(
      taskId: json['taskId'] ?? '',
      userId: json['userId'] ?? '',
      taskName: json['taskName'] ?? '',
      tags: json['tags'] ?? 0,
      difficultyLevel: json['difficultyLevel'] ?? 0,
      status: json['status'] ?? 0,
      startDate: json['startDate'] ?? '',
      endTime: json['endTime'] ?? '',
      imageId: json['imageId'] ?? '',
      advice: json['advice'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'userId': userId,
      'taskName': taskName,
      'tags': tags,
      'difficultyLevel': difficultyLevel,
      'status': status,
      'startDate': startDate,
      'endTime': endTime,
      'imageId': imageId,
      'advice': advice,
    }; 
  }
}