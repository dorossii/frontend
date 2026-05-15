// ==============================================
// widgets/effects/darkness_layer.dart
// ==============================================

import 'package:flutter/material.dart';

import '../../models/state_theme.dart';

class DarknessLayer extends StatelessWidget {

  final StateTheme theme;

  const DarknessLayer({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned.fill(

      child: IgnorePointer(

        child: Container(
          color: Colors.black.withOpacity(
            theme.darkness,
          ),
        ),
      ),
    );
  }
}