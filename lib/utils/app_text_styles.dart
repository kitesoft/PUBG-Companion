import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextStyle title = new TextStyle(
      fontFamily: 'Assistant', fontWeight: FontWeight.w600, fontSize: 25.0);
  static TextStyle headline = new TextStyle(
      fontFamily: 'HeadlinerNo45', fontSize: 40.0, color: Colors.orange);
  static TextStyle weaponsBarLabel = new TextStyle(
      fontFamily: 'Assistant', fontWeight: FontWeight.w400, fontSize: 25.0);
  static TextStyle weaponsCardHeader = new TextStyle(
      fontFamily: 'Teko', fontWeight: FontWeight.w400, fontSize: 25.0);
  static TextStyle weaponsCardRatingCategory = new TextStyle(
      fontFamily: 'Assistant', fontWeight: FontWeight.w600, fontSize: 20.0);
  static TextStyle weaponsCardRatingValue = new TextStyle(
      fontFamily: 'Assistant',
      fontWeight: FontWeight.w300,
      fontSize: 20.0,
      color: Colors.blueGrey);
  static TextStyle weaponsSortOption = new TextStyle(
      fontFamily: 'Assistant', fontWeight: FontWeight.w400, fontSize: 16.0);
  static TextStyle weaponInfoHeader = new TextStyle(
      fontFamily: 'Teko', fontWeight: FontWeight.w600, fontSize: 55.0);
  static TextStyle weaponInfoSubheader = new TextStyle(
      fontFamily: 'Teko', fontWeight: FontWeight.w400, fontSize: 30.0);
  static TextStyle weaponInfoManufacturer = new TextStyle(
      fontFamily: 'Teko', fontWeight: FontWeight.w400, fontSize: 25.0);
  static TextStyle weaponInfoHeaderRow = new TextStyle(
      fontFamily: 'Assistant', fontWeight: FontWeight.w600, fontSize: 20.0);
  static TextStyle weaponInfoRow = new TextStyle(
      fontFamily: 'Assistant', fontWeight: FontWeight.w400, fontSize: 18.0);
  static TextStyle weaponInfoRaisedButton = new TextStyle(
      fontFamily: 'Assistant', fontWeight: FontWeight.w600, fontSize: 16.0);
}
