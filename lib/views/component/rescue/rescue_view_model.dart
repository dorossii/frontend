import 'package:flutter/material.dart';

import '../../../models/friend_rescue.dart';
import '../../../services/friend/friend_rescue_service.dart';

// レスキューのビューモデル
class RescueViewModel extends ChangeNotifier {
  Future<List<RescueFriend>> getFriends() async {
    return await FriendRescueService().fetchFriendInfo();
  }
}