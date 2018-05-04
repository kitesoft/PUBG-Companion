import 'package:flutter/material.dart';
import 'package:pubg_companion/utils/font_awesome_icon_data.dart';

class AppThemes {
  String name;
  IconData icon;
  ThemeData theme;

  AppThemes({this.name, this.icon, this.theme});
}

final List<AppThemes> kAllAppThemes = <AppThemes>[
  new AppThemes(
    name: 'Dark (Default)',
    icon: FontAwesomeIcons.moon,
    theme: new ThemeData(
        primaryColor: const Color(0xFF1D2027),
        accentColor: const Color(0xFFF3A03A),
        scaffoldBackgroundColor: const Color(0xFF0F0F19),
        accentIconTheme: const IconThemeData(color: Colors.white),
        dividerColor: const Color(0xFF95969A),
        brightness: Brightness.dark,
        cardColor: const Color(0xFF1D2027),
        //splashColor: new Color(0xFF62431d),
        splashFactory: InkRipple.splashFactory,
        primaryIconTheme: const IconThemeData(color: const Color(0xFFf3A03A))),
  ),
  new AppThemes(
    name: 'Light',
    icon: FontAwesomeIcons.sun,
    theme: new ThemeData(
      primaryColor: Colors.blueGrey,
      accentColor: const Color(0xFFf3A03A),
      scaffoldBackgroundColor: Colors.white,
      accentIconTheme: const IconThemeData(color: Colors.white),
      dividerColor: Colors.blueGrey,
      brightness: Brightness.light,
      //splashColor: new Color(0xFFFFDCB1),
      splashFactory: InkRipple.splashFactory,
    ),
  ),
];
