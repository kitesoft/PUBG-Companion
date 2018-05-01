import 'package:flutter/material.dart';
import 'package:pubg_companion/models/weapon.dart';
import 'package:pubg_companion/utils/app_text_styles.dart';
import 'package:pubg_companion/utils/font_awesome_icon_data.dart';

class WeaponInfo extends StatelessWidget {
  final Weapon weapon;

  WeaponInfo(this.weapon);

  static const String routeName = "/WeaponInfo";

  @override
  Widget build(BuildContext context) {
    List<String> _country = weapon.country.split('/');
    List<Widget> _flags = [];
    _country.forEach((String c) {
      _flags.add(
        new Container(
          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: (c == 'ussr' || c == 'nazi')
              ? (c == 'ussr')
                  ? new Image(image: AssetImage('assets/images/flags/ussr.png'))
                  : new Image(image: AssetImage('assets/images/flags/nazi.png'))
              : new Image(
                  image: new NetworkImage(
                      'http://www.countryflags.io/$c/shiny/32.png')),
        ),
      );
    });

    return new Scaffold(
      persistentFooterButtons: <Widget>[
        new Text('Compare weapons'),
        new IconButton(
            tooltip: 'Compare',
            icon: new Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
              size: 30.0,
            ),
            onPressed: () {})
      ],
      appBar: new AppBar(
        title: new Text(
          'Weapon Details: ' + weapon.name,
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add), onPressed: () {})
        ],
      ),
      body: new Container(
        padding: EdgeInsets.only(top: 5.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Center(
              child: new Stack(
                alignment: Alignment(0.0, 0.0),
                children: <Widget>[
                  new Opacity(
                    opacity: 0.05,
                    child: new Icon(
                      FontAwesomeIcons.bullseye_light,
                      size: 165.0,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  new Hero(
                    tag: 'weapon-hero-${weapon.name}',
                    child: new Image(
                      image: new AssetImage(
                        'assets/images/weapons/' +
                            weapon.name.replaceAll(' ', '_') +
                            '.png',
                      ),
                      width: 225.0,
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              constraints: new BoxConstraints(maxHeight: 60.0),
              child: new Text(
                weapon.name,
                style: AppTextStyles.weaponInfoHeader,
              ),
            ),
            new Container(
              constraints: new BoxConstraints(maxHeight: 37.5),
              child: new Text(
                weapon.fullName,
                style: AppTextStyles.weaponInfoSubheader,
                maxLines: 1,
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _flags +
                  <Widget>[
                    new Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: new Text(
                        weapon.manufacturer,
                        style: AppTextStyles.weaponInfoManufacturer,
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }
}
