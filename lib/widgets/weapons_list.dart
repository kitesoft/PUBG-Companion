import 'package:flutter/material.dart';
import 'package:pubg_companion/models/weapon.dart';
import 'package:pubg_companion/utils/app_text_styles.dart';

class WeaponsList extends StatefulWidget {
  final List<Weapon> weapons;
  final GlobalKey<ScaffoldState> scaffoldKey;

  WeaponsList({Key key, this.weapons, this.scaffoldKey}) : super(key: key);

  @override
  _WeaponsListState createState() =>
      new _WeaponsListState(weapons: weapons, scaffoldKey: scaffoldKey);
}

class _WeaponsListState extends State<WeaponsList> {
  List<Weapon> weapons;
  final GlobalKey<ScaffoldState> scaffoldKey;

  _WeaponsListState({this.weapons, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new ListView.builder(
      itemCount: weapons.length,
      itemBuilder: (context, index) {
        return new Column(children: <Widget>[
          new Tooltip(
            message: 'Show Weapon Stats',
            child: new Container(
              child: new Card(
                child: Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                              child: new Text(
                                weapons[index].name,
                                style: AppTextStyles.weaponsCardHeader,
                              ),
                              padding: EdgeInsets.fromLTRB(10.0, 2.5, 0.0, 0.0),
                            ),
                            new Container(
                              child: Row(
                                  children: weapons[index].ammo != 'None'
                                      ? <Widget>[
                                          new Container(
                                            padding:
                                                EdgeInsets.only(right: 5.0),
                                            child: new Image(
                                                height: 30.0,
                                                image: new AssetImage(
                                                    'assets/images/ammo/' +
                                                        weapons[index]
                                                            .ammo
                                                            .replaceAll('.', '')
                                                            .replaceAll(
                                                                ' ', '_') +
                                                        '.png')),
                                          ),
                                          new Text(
                                            weapons[index].ammo,
                                            style:
                                                AppTextStyles.weaponsCardHeader,
                                          )
                                        ]
                                      : <Widget>[]),
                              padding: EdgeInsets.fromLTRB(0.0, 2.5, 10.0, 0.0),
                            )
                          ],
                        ))
                      ],
                    ),
                    new Divider(),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 20.0),
                          child: new Image(
                              height: 100.0,
                              image: new AssetImage('assets/images/weapons/' +
                                  weapons[index].name.replaceAll(' ', '_') +
                                  '.png')),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          new Divider(
            height: 20.0,
          )
        ]);
      },
    ));
  }
}
