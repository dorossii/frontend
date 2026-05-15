/// ===============================
/// キャラクターの状態
/// ===============================
enum LifeState {

  rip(8),

  critical(7),

  danger(6),

  dirty(5),

  normal(4),

  slightlyDirty(3),

  clean(2),

  perfect(1),

  god(0);

  final int value;

  const LifeState(this.value);

  /// 数値 → enum変換
  static LifeState fromValue(int value) {

    return LifeState.values.firstWhere(
      (state) => state.value == value,

      /// 不正値対策
      orElse: () => LifeState.normal,
    );
  }
}