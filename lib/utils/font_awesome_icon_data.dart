library font_awesome_icon_data;

import 'package:flutter/widgets.dart';

class FontAwesomeIcons {
  static const IconData moon = const _IconDataSolid(0xf186);
  static const IconData sun = const _IconDataSolid(0xf185);
  static const IconData cog = const _IconDataSolid(0xf013);
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
