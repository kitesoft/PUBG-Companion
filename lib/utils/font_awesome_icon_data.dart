library font_awesome_icon_data;

import 'package:flutter/widgets.dart';

abstract class FontAwesomeIcons {
  // Drawer
  static const IconData cog = const _IconDataSolid(0xf013);

  // Bottom navigation
  static const IconData newspaper = const _IconDataSolid(0xf1ea);

  // Settings page
  static const IconData moon = const _IconDataSolid(0xf186);
  static const IconData sun = const _IconDataSolid(0xf185);

  // Tweets page
  static const IconData link = const _IconDataSolid(0xf0c1);
  static const IconData play = const _IconDataSolid(0xf04b);

  // Weapons page
  static const IconData sort_alpha_down = const _IconDataRegular(0xf15d);
  static const IconData bullseye = const _IconDataSolid(0xf140);
  static const IconData fire = const _IconDataSolid(0xf06d);
  static const IconData arrows_alt = const _IconDataSolid(0xf0b2);

  // Weapon Info page
  static const IconData bullseye_light = const _IconDataLight(0xf140);
  static const IconData info = const _IconDataSolid(0xf129);
  static const IconData chart_bar = const _IconDataSolid(0xf080);
  static const IconData images = const _IconDataSolid(0xf302);
  static const IconData wikipedia_w = const _IconDataBrands(0xf266);
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
