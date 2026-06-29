import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../components/Colors.dart';

class TypingText extends StatefulWidget {
  final String friendName;
  final VoidCallback? onFinished;

  const TypingText({
    super.key,
    required this.friendName,
    this.onFinished,
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  late final String _fullText;

  String _displayText = "";
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _fullText =
        "${widget.friendName}は"
        "動けなくなっているようだ\n\n"
        "しばらくタスクが"
        "進んでいない\n\n"
        "少し話すと、"
        "また動き出せるかもしれない";

    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 150),
      (timer) {
        if (_index >= _fullText.length) {
          timer.cancel();
          widget.onFinished?.call();
          return;
        }

        setState(() {
          _displayText += _fullText[_index];
          _index++;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: 'textFont',
        fontWeight: FontWeight.bold,
        color: AppColors.subWhiteBackground,
        height: 1.5,
      ),
    );
  }
}