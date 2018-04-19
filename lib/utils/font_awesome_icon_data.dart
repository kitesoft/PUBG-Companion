library font_awesome_icon_data;

import 'package:flutter/widgets.dart';

class FontAwesomeIcons {
  // Drawer
  static const IconData cog = const _IconDataSolid(0xf013);

  // Bottom navigation
  static const IconData newspaper = const _IconDataSolid(0xf1ea);
  static const IconData crosshairs = const _IconDataRegular(0xf05b);

  // Settings page
  static const IconData moon = const _IconDataSolid(0xf186);
  static const IconData sun = const _IconDataSolid(0xf185);

  // Tweets page
  static const IconData link = const _IconDataSolid(0xf0c1);
  static const IconData play = const _IconDataSolid(0xf04b);
}

class _IconDataBrands extends IconData {
  const _IconDataBrands(int codePoint)
      : super(
          codePoint,
          fontFamily: 'FontAwesomeBrands',
        );
}

class _IconDataSolid extends IconData {
  const _IconDataSolid(int codePoint)
      : super(
          codePoint,
          fontFamily: 'FontAwesomeSolid',
        );
}

class _IconDataRegular extends IconData {
  const _IconDataRegular(int codePoint)
      : super(
          codePoint,
          fontFamily: 'FontAwesomeRegular',
        );
}

class _IconDataLight extends IconData {
  const _IconDataLight(int codePoint)
      : super(
          codePoint,
          fontFamily: 'FontAwesomeLight',
        );
}
