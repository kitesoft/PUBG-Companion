library govicons_icon_data;

import 'package:flutter/widgets.dart';

class GovIcons {
  // Bottom navigation
  static const IconData gun = const _IconDataSolid(0xe915);
}

class _IconDataSolid extends IconData {
  const _IconDataSolid(int codePoint)
      : super(
          codePoint,
          fontFamily: 'GovIcons',
        );
}