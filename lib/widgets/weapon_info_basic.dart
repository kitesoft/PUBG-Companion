import 'package:flutter/material.dart';
import 'package:pubg_companion/models/weapon.dart';
import 'package:pubg_companion/utils/app_text_styles.dart';
import 'package:pubg_companion/utils/weapons_rating.dart';

class WeaponInfoBasic extends StatelessWidget {
  final Weapon weapon;

  WeaponInfoBasic(this.weapon);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Start of damage
        new Container(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 5.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                child: new Text('Damage:',
                    style: AppTextStyles.weaponsCardRatingCategory),
              ),
              new Container(
                child: new Text(
                    WeaponsRating.weaponDamageValue(weapon).toString(),
                    style: AppTextStyles.weaponsCardRatingValue),
              ),
            ],
          ),
        ),
        new Container(
            padding: EdgeInsets.only(bottom: 5.0),
            child: WeaponsRating.weaponDamageBar(weapon)),
        // End of damage
        // Start of accuracy
        new Container(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 5.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                child: new Text('Accuracy:',
                    style: AppTextStyles.weaponsCardRatingCategory),
              ),
              new Container(
                child: new Text(
                    WeaponsRating.weaponAccuracyValue(weapon).toString(),
                    style: AppTextStyles.weaponsCardRatingValue),
              ),
            ],
          ),
        ),
        new Container(
            padding: EdgeInsets.only(bottom: 7.0),
            child: WeaponsRating.weaponAccuracyBar(weapon)),
        // End of accuracy
        // Start of range
        new Container(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 5.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                child: new Text('Range:',
                    style: AppTextStyles.weaponsCardRatingCategory),
              ),
              new Container(
                child: new Text(
                    WeaponsRating.weaponRangeValue(weapon).toString(),
                    style: AppTextStyles.weaponsCardRatingValue),
              ),
            ],
          ),
        ),
        new Container(
            padding: EdgeInsets.only(bottom: 15.0),
            child: WeaponsRating.weaponRangeBar(weapon)),
        // End of range
      ],
    );
  }
}
