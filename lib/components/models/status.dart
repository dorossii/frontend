/// ===============================
/// キャラクターの状態
/// ===============================
enum LifeState {

  rip(0),

  critical(1),

  danger(2),

  dirty(3),

  normal(4),

  slightlyDirty(5),

  clean(6),

  perfect(7),

  god(8);

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