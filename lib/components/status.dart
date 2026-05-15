/// ===============================
/// キャラクターの状態
/// ===============================
enum LifeState {
  // 死亡状態
  // HP 0
  rip,
  // 超危険
  // 汚さ 851 ~ 1000
  critical,
  // 危険
  // 汚さ 701 ~ 850
  danger,
  // 汚い
  // 汚さ 501 ~ 700
  dirty,
  // 普通
  // 汚さ 301 ~ 500
  normal,
  // 少し汚い
  // 汚さ 151 ~ 300
  slightlyDirty,
  /// 綺麗
  /// 汚さ 0 ~ 150
  clean,
  /// 超綺麗
  perfect,

  /// 神状態
  god,
}

// キャラクターの状態を判定する関数
LifeState getLifeState({
  required int dirt,
  required bool isRip,
  required bool isGod,
}) {

  // ===============================
  // RIP判定
  // ===============================
  if (isRip) {
    return LifeState.rip;
  }

  // ===============================
  // GOD判定
  // ===============================
  if (isGod) {
    return LifeState.god;
  }

  // ===============================
  // 汚さによる状態変化
  // ===============================

  // 0 ~ 50
  if (dirt <= 50) {
    return LifeState.perfect;
  }

  // 51 ~ 150
  if (dirt <= 150) {
    return LifeState.clean;
  }

  // 151 ~ 300
  if (dirt <= 300) {
    return LifeState.slightlyDirty;
  }

  // 301 ~ 500
  if (dirt <= 500) {
    return LifeState.normal;
  }

  // 501 ~ 700
  if (dirt <= 700) {
    return LifeState.dirty;
  }

  // 701 ~ 850
  if (dirt <= 850) {
    return LifeState.danger;
  }

  // 851 ~ 1000
  return LifeState.critical;
}

