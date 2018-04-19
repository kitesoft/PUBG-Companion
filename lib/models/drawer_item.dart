import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DrawerNavigationItem {
  final String title;
  final String routeName;
  final String description;
  final Icon icon;

  DrawerNavigationItem(
      {@required this.title,
      @required this.routeName,
      this.description,
      this.icon});
}

class BottomNavigationItem {
  final String title;
  final Widget pageWidget;
  final String description;
  final Icon icon;

  BottomNavigationItem(
      {@required this.title,
      @required this.pageWidget,
      this.description,
      this.icon});
}
