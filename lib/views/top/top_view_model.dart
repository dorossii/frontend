import 'dart:async';

import '../../components/models/status.dart';

class TopViewModel {

  /// 現在状態
  LifeState currentState =
      LifeState.normal;

  /// デバッグ用
  int currentIndex = 0;

  Timer? timer;

  List<LifeState> states =
      LifeState.values;

  /// ===================================
  /// デバッグ切り替え
  /// ===================================
  void startDebugLoop(
    void Function() onUpdate,
  ) {

    timer = Timer.periodic(

      const Duration(seconds: 3),

      (_) {

        currentIndex++;

        if (currentIndex >= states.length) {
          currentIndex = 0;
        }

        currentState =
            states[currentIndex];

        onUpdate();
      },
    );
  }

  void dispose() {
    timer?.cancel();
  }
}