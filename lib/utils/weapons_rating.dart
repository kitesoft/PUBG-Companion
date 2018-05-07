import 'package:flutter/material.dart';
import 'package:pubg_companion/models/weapon.dart';
import 'package:pubg_companion/utils/font_awesome_icon_data.dart';
import 'package:pubg_companion/utils/govicons_icon_data.dart';

abstract class WeaponsRating {
  static int _mostDamage = 225;
  static int _highestRange = 650;

  static List<Color> _ratingGradient = [
    new Color(0xFF0578e3), // 1
    new Color(0xFF057edd),
    new Color(0xFF0484d6),
    new Color(0xFF048bcf),
    new Color(0xFF0390c8), // 5
    new Color(0xFF0397c1),
    new Color(0xFF039dbb),
    new Color(0xFF04a4b4),
    new Color(0xFF02a9ad),
    new Color(0xFF02b0a6), // 10
    new Color(0xFF03b7a0),
    new Color(0xFF02bd99),
    new Color(0xFF02c392),
    new Color(0xFF02c98c),
    new Color(0xFF02cf86), // 15
    new Color(0xFF01d67e),
    new Color(0xFF01dc77),
    new Color(0xFF01e271),
    new Color(0xFF01e96b),
    new Color(0xFF00ef64), // 20
  ];

  static int weaponDamageValue(Weapon weapon) {
    return weapon.damage;
  }

  static Widget weaponDamageBar(Weapon weapon) {
    int damageScore =
        (weaponDamageValue(weapon) / _mostDamage * _ratingGradient.length)
            .round();

    List<Widget> rating = [];

    for (var i = 0; i < damageScore; i++) {
      Widget temp = new Container(
          padding: EdgeInsets.only(right: 0.0),
          child: new Icon(
            GovIcons.poison,
            size: 13.7,
            color: _ratingGradient[i],
          ));

      rating.add(temp);
    }

    Widget damageRatingBar = new Row(
      children: rating,
    );

    return damageRatingBar;
  }

  static int weaponRangeValue(Weapon weapon) {
    return weapon.range;
  }

  static Widget weaponRangeBar(Weapon weapon) {
    int rangeScore =
        (weaponRangeValue(weapon) / _highestRange * _ratingGradient.length)
            .round();
    List<Widget> rating = [];

    for (var i = 0; i < rangeScore; i++) {
      Widget temp = new Container(
          padding: EdgeInsets.only(right: 2.7),
          child: new Icon(
            FontAwesomeIcons.arrows_alt,
            size: 11.0,
            color: _ratingGradient[i],
          ));

      rating.add(temp);
    }

    Widget rangeRatingBar = new Row(
      children: rating,
    );

    return rangeRatingBar;
  }

/*  static int weaponDamageValue(Weapon weapon) {
    return (weapon.damage / 225 * 100).round();
  }*/

/*  static Widget weaponDamageBar(Weapon weapon) {
    int damage = (weaponDamageValue(weapon) / 5).round();
    List<Widget> rating = [];

    for (var i = 0; i < damage; i++) {
      Widget temp = new Container(
          padding: EdgeInsets.only(right: 0.0),
          child: new Icon(
            GovIcons.poison,
            size: 13.7,
            color: _ratingGradient[i],
          ));

      rating.add(temp);
    }

    Widget damageRatingBar = new Row(
      children: rating,
    );

    return damageRatingBar;
  }*/

  static int weaponAccuracyValue(Weapon weapon) {
    return (0.03 / weapon.scopedSpread * 100).round();
  }

  static Widget weaponAccuracyBar(Weapon weapon) {
    int accuracy = (weaponAccuracyValue(weapon) / 5).round();
    List<Widget> rating = [];

    for (var i = 0; i < accuracy; i++) {
      Widget temp = new Container(
          padding: EdgeInsets.only(right: 2.7),
          child: new Icon(
            FontAwesomeIcons.bullseye,
            size: 11.0,
            color: _ratingGradient[i],
          ));

      rating.add(temp);
    }

    Widget accuracyRatingBar = new Row(
      children: rating,
    );

    return accuracyRatingBar;
  }

  /*static int weaponRangeValue(Weapon weapon) {
    return (weapon.range / 650 * 100).round();
  }

  static Widget weaponRangeBar(Weapon weapon) {
    int range = (weaponRangeValue(weapon) / 5).round();
    List<Widget> rating = [];

    for (var i = 0; i < range; i++) {
      Widget temp = new Container(
          padding: EdgeInsets.only(right: 2.7),
          child: new Icon(
            FontAwesomeIcons.arrows_alt,
            size: 11.0,
            color: _ratingGradient[i],
          ));

      rating.add(temp);
    }

    Widget rangeRatingBar = new Row(
      children: rating,
    );

    return rangeRatingBar;
  }*/
}
