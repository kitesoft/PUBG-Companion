import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubg_companion/models/weapon.dart';
import 'package:pubg_companion/utils/app_text_styles.dart';
import 'package:pubg_companion/utils/font_awesome_icon_data.dart';
import 'package:url_launcher/url_launcher.dart';

class WeaponInfo extends StatelessWidget {
  final Weapon weapon;

  WeaponInfo(this.weapon);

  static const String routeName = "/WeaponInfo";

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        constraints: new BoxConstraints.expand(),
        child: new ListView(
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
              child: new Center(
                child: new Text(
                  weapon.name,
                  style: AppTextStyles.weaponInfoHeader,
                ),
              ),
            ),
            new Container(
              constraints: new BoxConstraints(maxHeight: 37.5),
              child: new Center(
                child: new Text(
                  weapon.fullName,
                  style: AppTextStyles.weaponInfoSubheader,
                  maxLines: 1,
                ),
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
            new Container(
              color: new Color(0xFF171a25),
              margin: EdgeInsets.only(top: 10.0, bottom: 30.0),
              child: new Column(
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      new Image(
                        height: 40.0,
                        image:
                            new AssetImage('assets/images/ui/header_row.png'),
                        fit: BoxFit.fitHeight,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(
                              FontAwesomeIcons.info,
                              color: Theme.of(context).accentColor,
                              size: 20.0,
                            ),
                            new Container(
                              padding: EdgeInsets.only(top: 2.0, left: 5.0),
                              child: new Text(
                                'Info'.toUpperCase(),
                                style: AppTextStyles.weaponInfoHeaderRow,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15.0, right: 15.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Flexible(
                                    child: new Column(
                                      children: <Widget>[
                                        new Text(
                                          weapon.wikipediaSummary,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.weaponInfoRow,
                                        ),
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, bottom: 20.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              new RaisedButton.icon(
                                                onPressed: () {
                                                  _launchInBrowser(
                                                      weapon.wikipediaLink);
                                                },
                                                icon: new Icon(
                                                  FontAwesomeIcons.wikipedia_w,
                                                  size: 15.0,
                                                ),
                                                label: new Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: new Text(
                                                    'Wikipedia'.toUpperCase(),
                                                    style: AppTextStyles
                                                        .weaponInfoRaisedButton,
                                                  ),
                                                ),
                                                elevation: 3.0,
                                                highlightElevation: 0.0,
                                              ),
                                              new RaisedButton(
                                                color: Colors.blueGrey[800],
                                                onPressed: () {
                                                  _launchInBrowser(
                                                      'https://pubg.gamepedia.com/${weapon.name}');
                                                },
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Image(
                                                        height: 20.0,
                                                        image: new AssetImage(
                                                            'assets/images/ui/gamepedia_logo.png')),
                                                    new Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: new Text(
                                                        'PUBG Wiki'
                                                            .toUpperCase(),
                                                        style: AppTextStyles
                                                            .weaponInfoRaisedButton,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                elevation: 3.0,
                                                highlightElevation: 0.0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            new Container(
              color: new Color(0xFF171a25),
              margin: EdgeInsets.only(bottom: 30.0),
              child: new Column(
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      new Image(
                        height: 40.0,
                        image:
                            new AssetImage('assets/images/ui/header_row.png'),
                        fit: BoxFit.fitHeight,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(
                              FontAwesomeIcons.chart_bar,
                              color: Theme.of(context).accentColor,
                              size: 20.0,
                            ),
                            new Container(
                              padding: EdgeInsets.only(top: 2.0, left: 7.0),
                              child: new Text(
                                'Stats'.toUpperCase(),
                                style: AppTextStyles.weaponInfoHeaderRow,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15.0, right: 15.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Flexible(
                                    child: new Column(
                                      children: <Widget>[
                                        new Text(
                                          weapon.wikipediaSummary,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.weaponInfoRow,
                                        ),
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, bottom: 20.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              new RaisedButton.icon(
                                                onPressed: () {},
                                                icon: new Icon(
                                                  FontAwesomeIcons.wikipedia_w,
                                                  size: 15.0,
                                                ),
                                                label: new Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: new Text(
                                                    'Wikipedia'.toUpperCase(),
                                                    style: AppTextStyles
                                                        .weaponInfoRaisedButton,
                                                  ),
                                                ),
                                                elevation: 3.0,
                                                highlightElevation: 0.0,
                                              ),
                                              new RaisedButton(
                                                color: Colors.blueGrey[800],
                                                onPressed: () {},
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Image(
                                                        height: 20.0,
                                                        image: new AssetImage(
                                                            'assets/images/ui/gamepedia_logo.png')),
                                                    new Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: new Text(
                                                        'PUBG Wiki'
                                                            .toUpperCase(),
                                                        style: AppTextStyles
                                                            .weaponInfoRaisedButton,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                elevation: 3.0,
                                                highlightElevation: 0.0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            new Container(
              color: new Color(0xFF171a25),
              margin: EdgeInsets.only(bottom: 30.0),
              child: new Column(
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      new Image(
                        height: 40.0,
                        image:
                            new AssetImage('assets/images/ui/header_row.png'),
                        fit: BoxFit.fitHeight,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(
                              FontAwesomeIcons.images,
                              color: Theme.of(context).accentColor,
                              size: 20.0,
                            ),
                            new Container(
                              padding: EdgeInsets.only(top: 2.0, left: 10.0),
                              child: new Text(
                                'Gallery'.toUpperCase(),
                                style: AppTextStyles.weaponInfoHeaderRow,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15.0, right: 15.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Flexible(
                                    child: new Column(
                                      children: <Widget>[
                                        new Text(
                                          weapon.wikipediaSummary,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.weaponInfoRow,
                                        ),
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, bottom: 20.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              new RaisedButton.icon(
                                                onPressed: () {},
                                                icon: new Icon(
                                                  FontAwesomeIcons.wikipedia_w,
                                                  size: 15.0,
                                                ),
                                                label: new Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: new Text(
                                                    'Wikipedia'.toUpperCase(),
                                                    style: AppTextStyles
                                                        .weaponInfoRaisedButton,
                                                  ),
                                                ),
                                                elevation: 3.0,
                                                highlightElevation: 0.0,
                                              ),
                                              new RaisedButton(
                                                color: Colors.blueGrey[800],
                                                onPressed: () {},
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Image(
                                                        height: 20.0,
                                                        image: new AssetImage(
                                                            'assets/images/ui/gamepedia_logo.png')),
                                                    new Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: new Text(
                                                        'PUBG Wiki'
                                                            .toUpperCase(),
                                                        style: AppTextStyles
                                                            .weaponInfoRaisedButton,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                elevation: 3.0,
                                                highlightElevation: 0.0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
