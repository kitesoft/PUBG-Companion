import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pubg_companion/models/weapon.dart';
import 'package:pubg_companion/pages/home_page.dart';
import 'package:pubg_companion/pages/weapon_info.dart';
import 'package:pubg_companion/utils/app_text_styles.dart';
import 'package:pubg_companion/utils/weapons_rating.dart';

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
  ScrollController _weaponsScrollController;

  _WeaponsListState({this.weapons, this.scaffoldKey});

  List _weaponsSort(List list, String comparator) {
    switch (comparator) {
      case 'name':
        for (var i = 0; i < list.length; i++) {
          for (var j = i + 1; j < list.length; j++) {
            if (list[i].name.compareTo(list[j].name) > 0) {
              var tmp = list[i];
              list[i] = list[j];
              list[j] = tmp;
            }
          }
        }
        break;
      case 'damage':
        for (var i = 0; i < list.length; i++) {
          for (var j = i + 1; j < list.length; j++) {
            if (list[i].damage.compareTo(list[j].damage) < 0) {
              var tmp = list[i];
              list[i] = list[j];
              list[j] = tmp;
            }
          }
        }
        break;
      case 'accuracy':
        for (var i = 0; i < list.length; i++) {
          for (var j = i + 1; j < list.length; j++) {
            if (list[i].scopedSpread().compareTo(list[j].scopedSpread()) > 0) {
              var tmp = list[i];
              list[i] = list[j];
              list[j] = tmp;
            }
          }
        }
        break;
      case 'range':
        for (var i = 0; i < list.length; i++) {
          for (var j = i + 1; j < list.length; j++) {
            if (list[i].range.compareTo(list[j].range) < 0) {
              var tmp = list[i];
              list[i] = list[j];
              list[j] = tmp;
            }
          }
        }
        break;
    }
    return list;
  }

  @override
  void initState() {
    super.initState();

    _weaponsSort(weapons, HomePage.sortRadioValue);

    _weaponsScrollController = new ScrollController();

    _weaponsScrollController.addListener(() {
      if (_weaponsScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        HomePage.fabListener.value = false;
      } else {
        HomePage.fabListener.value = true;
      }
    });

    // TODO: test, build animation for FAB
    Future.delayed(const Duration(milliseconds: 5), () {
      HomePage.fabListener.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _weaponsSort(weapons, HomePage.sortRadioValue);
    return new Expanded(
        child: new ListView.builder(
      controller: _weaponsScrollController,
      itemCount: weapons.length,
      itemBuilder: (context, index) {
        return new Column(children: <Widget>[
          new Tooltip(
            message: 'Show ' + weapons[index].name + ' Stats',
            child: new InkWell(
              onTap: () => Navigator.of(context).push(new PageRouteBuilder(
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return new SlideTransition(
                          position: new Tween<Offset>(
                            begin: const Offset(-1.0, 0.0),
                            end: Offset.zero,
                          ).animate(new CurvedAnimation(
                            parent:
                                animation, // The route's linear 0.0 - 1.0 animation.
                            curve: Curves.fastOutSlowIn,
                          )),
                          child: child);
                    },
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => new WeaponInfo(weapons[index]),
                  )),
              child: new Container(
                padding: EdgeInsets.only(bottom: 7.0, left: 5.0, right: 5.0),
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
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 4.0, 0.0, 0.0),
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
                                                              .replaceAll(
                                                                  '.', '')
                                                              .replaceAll(
                                                                  ' ', '_') +
                                                          '.png')),
                                            ),
                                            new Text(
                                              weapons[index].ammo,
                                              style: AppTextStyles
                                                  .weaponsCardHeader,
                                            )
                                          ]
                                        : <Widget>[]),
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 2.5, 10.0, 0.0),
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
                            padding: EdgeInsets.fromLTRB(2.5, 5.0, 7.5, 20.0),
                            child: new Hero(
                              tag: 'weapon-hero-${weapons[index].name}',
                              child: new Image(
                                  height: 100.0,
                                  image: new AssetImage(
                                      'assets/images/weapons/' +
                                          weapons[index]
                                              .name
                                              .replaceAll(' ', '_') +
                                          '.png')),
                            ),
                          ),
                          new Expanded(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Start of damage
                                new Container(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 5.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Container(
                                        child: new Text('Damage:',
                                            style: AppTextStyles
                                                .weaponsCardRatingCategory),
                                      ),
                                      new Container(
                                        child: new Text(
                                            WeaponsRating
                                                .weaponDamageValue(
                                                    weapons[index])
                                                .toString(),
                                            style: AppTextStyles
                                                .weaponsCardRatingValue),
                                      ),
                                    ],
                                  ),
                                ),
                                new Container(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: WeaponsRating
                                        .weaponDamageBar(weapons[index])),
                                // End of damage
                                // Start of accuracy
                                new Container(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 5.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Container(
                                        child: new Text('Accuracy:',
                                            style: AppTextStyles
                                                .weaponsCardRatingCategory),
                                      ),
                                      new Container(
                                        child: new Text(
                                            WeaponsRating
                                                .weaponAccuracyValue(
                                                    weapons[index])
                                                .toString(),
                                            style: AppTextStyles
                                                .weaponsCardRatingValue),
                                      ),
                                    ],
                                  ),
                                ),
                                new Container(
                                    padding: EdgeInsets.only(bottom: 7.0),
                                    child: WeaponsRating
                                        .weaponAccuracyBar(weapons[index])),
                                // End of accuracy
                                // Start of range
                                new Container(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 5.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Container(
                                        child: new Text('Range:',
                                            style: AppTextStyles
                                                .weaponsCardRatingCategory),
                                      ),
                                      new Container(
                                        child: new Text(
                                            WeaponsRating
                                                .weaponRangeValue(
                                                    weapons[index])
                                                .toString(),
                                            style: AppTextStyles
                                                .weaponsCardRatingValue),
                                      ),
                                    ],
                                  ),
                                ),
                                new Container(
                                    padding: EdgeInsets.only(bottom: 15.0),
                                    child: WeaponsRating
                                        .weaponRangeBar(weapons[index])),
                                // End of range
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]);
      },
    ));
  }
}
