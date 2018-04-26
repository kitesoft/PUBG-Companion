library govicons_icon_data;

import 'package:flutter/widgets.dart';

abstract class GovIcons {
  // Bottom navigation
  static const IconData gun = const _IconDataSolid(0xe915);

  // Weapons page
  static const IconData poison = const _IconDataSolid(0xe97a);
}

class _IconDataSolid extends IconData {
  const _IconDataSolid(int codePoint)
      : super(
          codePoint,
          fontFamily: 'GovIcons',
        );
}