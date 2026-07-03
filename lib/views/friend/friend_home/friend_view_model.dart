import '../../../components/models/status.dart';
import '../../../models/friend_info.dart';

class FriendHomeViewModel {
  final FriendInfo friendInfo;

  FriendHomeViewModel({required this.friendInfo});

  String get friendName => friendInfo.userName;

  int get dirtLevel => friendInfo.dirtLevel;

  int get hp => friendInfo.healthPoint;

  LifeState get currentState => LifeState.fromValue(friendInfo.dirtLevel);
  bool get isEvent => dirtLevel == 8;
}
