class ActivityLog {
  final int notifiedAt;
  final String senderType;
  final String title;

  ActivityLog({
    required this.notifiedAt,
    required this.senderType,
    required this.title,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      notifiedAt: json['notifiedAt'] ?? 0,
      senderType: json['senderType'] ?? '',
      title: json['title'] ?? '',
    );
  }

  // Unixタイムスタンプ（秒）を DateTime に変換
  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(notifiedAt * 1000);

  // 表示用の日付文字列（例: 2026/04/27）
  String get formattedDate {
    final dt = dateTime;
    final year = dt.year;
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    return '$year/$month/$day';
  }

  // 画面表示用テキスト（例: "2026/04/27 イベント開始のお知らせ"）
  String get displayText => '$formattedDate $title';
}