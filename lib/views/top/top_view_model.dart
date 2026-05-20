import 'dart:async';

import 'package:flutter/material.dart';
import '../../components/models/status.dart';

class TopViewModel extends ChangeNotifier {

  /// デバッグモード
  final bool isDebugMode;

  TopViewModel({
    this.isDebugMode = false,
  });

  /// 現在状態
  LifeState currentState = LifeState.normal;

  /// デバッグindex
  int currentIndex = 0;

  /// timer
  Timer? timer;

  /// 一覧
  List<LifeState> states = LifeState.values;

  /// 初期化
  void initialize() {

    if (isDebugMode) {
      startDebugLoop();
    }
  }

  /// デバッグ切り替え
  void startDebugLoop() {

    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {

        currentIndex++;

        if (currentIndex >= states.length) {
          currentIndex = 0;
        }

        currentState = states[currentIndex];

        notifyListeners();
      },
    );
  }

  @override
  void dispose() {

    timer?.cancel();

    super.dispose();
  }
}