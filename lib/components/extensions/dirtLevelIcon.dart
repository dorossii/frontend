
extension DirtLevelIcon on int {
  String get statusIcon {
    if (this > 5) {
      return 'images/status/zombieIcon.png';
    } else if (this > 3) {
      return 'images/status/human2Icon.png';
    } else if (this > 0) {
      return 'images/status/humanIcon.png';
    } else {
      return 'images/status/godIcon.png';
    }
  }
}