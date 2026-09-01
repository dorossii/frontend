String handleGetStartDate(int startDate) {
  final date = DateTime.fromMillisecondsSinceEpoch(startDate * 1000);
  final text = '${date.month}月${date.day}日(${_getWeekday(date)})';

  return text;
}

String _getWeekday(DateTime date) {
  const weekdays = [
    '月',
    '火',
    '水',
    '木',
    '金',
    '土',
    '日',
  ];

  return weekdays[date.weekday - 1];
}