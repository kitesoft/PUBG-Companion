import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubg_companion/api/weapons_api.dart';
import 'package:pubg_companion/models/weapon.dart';
import 'package:pubg_companion/utils/app_text_styles.dart';
import 'package:pubg_companion/widgets/weapons_list.dart';

List<String> weaponFamilies = const <String>[
  'Assault Rifle',
  'Sniper Rifle',
  'DMR',
  'SMG',
  'LMG',
  'Shotgun',
  'Pistol',
  'Melee',
  'Other',
];

class WeaponsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  WeaponsPage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _WeaponsPageState createState() =>
      new _WeaponsPageState(scaffoldKey: scaffoldKey);
}

class _WeaponsPageState extends State<WeaponsPage> {
  bool _topBarVisible;
  final GlobalKey<ScaffoldState> scaffoldKey;

  _WeaponsPageState({this.scaffoldKey});

  // TODO: add info with explanations and units

  @override
  void initState() {
    super.initState();

    _topBarVisible = false;

    Future.delayed(const Duration(microseconds: 1)).then((i) {
      setState(() {
        _topBarVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: new AnimatedCrossFade(
              firstChild: new Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: new TabBar(
                  indicatorWeight: 3.0,
                  indicatorColor: Theme.of(context).accentColor,
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Colors.white70,
                  isScrollable: true,
                  labelStyle: AppTextStyles.weaponsBarLabel,
                  tabs: new List.generate(weaponFamilies.length, (index) {
                    return new Container(
                        height: 55.0,
                        child:
                            new Tab(text: weaponFamilies[index].toUpperCase()));
                  }),
                ),
              ),
              secondChild: new Container(),
              crossFadeState: _topBarVisible == true
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
          new Expanded(
            child: new TabBarView(
              children:
                  new List<Widget>.generate(weaponFamilies.length, (int index) {
                return new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new FutureBuilder<List<Weapon>>(
                        future: WeaponsApi
                            .fetchWeapons(weaponFamilies[index] + ' Family'),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);

                          return snapshot.hasData
                              ? new WeaponsList(
                                  weapons: snapshot.data,
                                  scaffoldKey: scaffoldKey,
                                )
                              : new Container(
                                  padding: EdgeInsets.only(top: 50.0),
                                  child: new Center(
                                      child: new CircularProgressIndicator()),
                                );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
