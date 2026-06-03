// タスクのステータスを表すモデルクラス
class TaskInfo {
  final String taskId;        // タスクID
  final String userId;        // ユーザーID
  final String taskName;      // タスクのタイトル
  final int status;           // ステータス
  final int tags;             // 掃除カテゴリーのタグ
  final int level;            // 難易度
   final String description;   // タスク説明文
  final String startDate;     // 開始時間
  final String endTime;       // 終了時間
  final String imageId;       // 詳細画像
  final String message;       // 未承認時のフレンドからの


  TaskInfo({
    required this.taskId,
    required this.userId,
    required this.taskName,
    required this.status,
    required this.tags,
    required this.level,
    required this.description,
    required this.startDate,
    required this.endTime,
    required this.imageId,
    required this.message,
  });

  factory TaskInfo.fromJson(Map<String, dynamic> json) {
    return TaskInfo(
      taskId: json['taskId'] ?? '',
      userId: json['userId'] ?? '',
      taskName: json['taskName'] ?? '',
      tags: json['tags'] ?? 0,
      level: json['level'] ?? 0,
      status: json['status'] ?? 0,
      startDate: json['startDate'] ?? '',
      endTime: json['endTime'] ?? '',
      imageId: json['imageId'] ?? '',
      description: json['description'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'userId': userId,
      'taskName': taskName,
      'tags': tags,
      'level': level,
      'status': status,
      'startDate': startDate,
      'endTime': endTime,
      'imageId': imageId,
      'description': description,
      'message': message,
    }; 
  }
}