// ユーザの状態を表すクラス
class StatusResponse {

  final String userId;

  /// 0 ~ 8
  final int dirtLevel;

  final double healthPoint;

  const StatusResponse({
    required this.userId,
    required this.dirtLevel,
    required this.healthPoint,
  });

  factory StatusResponse.fromJson(
    Map<String, dynamic> json,
  ) {

    return StatusResponse(
      userId: json['userId'],

      dirtLevel: json['DirtLevel'],

      healthPoint:
          json['HealthPoint'].toDouble(),
    );
  }
}