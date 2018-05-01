import 'package:flutter/material.dart';
import 'package:pubg_companion/pages/home_page.dart';
import 'package:pubg_companion/pages/settings_page.dart';
import 'package:pubg_companion/utils/app_themes.dart';

void main() => runApp(new MyMaterialApp());

// Global Variables
ThemeData appTheme;

class MyMaterialApp extends StatefulWidget {
  @override
  _MyMaterialAppState createState() => new _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  AppThemes _appTheme;

  @override
  void initState() {
    super.initState();

    if (_appTheme == null) {
      _appTheme = kAllAppThemes[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget home = new HomePage(
      appTheme: _appTheme,
      onThemeChanged: (AppThemes value) {
        setState(() {
          _appTheme = value;
        });
      },
    );

    return new MaterialApp(
        title: 'PUBG Companion',
        home: home,
        theme: _appTheme.theme,
        routes: <String, WidgetBuilder>{
          SettingsPage.routeName: (BuildContext context) => new SettingsPage(
                title: 'Settings',
                appTheme: _appTheme,
                onThemeChanged: (AppThemes value) {
                  setState(() {
                    _appTheme = value;
                  });
                },
              ),
        });
  }
}
