import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pubg_companion/api/twitter_api.dart';
import 'package:pubg_companion/models/tweet.dart';
import 'package:pubg_companion/pages/settings.dart';
import 'package:pubg_companion/utils/app_text_styles.dart';
import 'package:pubg_companion/utils/app_themes.dart';
import 'package:pubg_companion/utils/font_awesome_icon_data.dart';
import 'package:pubg_companion/widgets/tweets_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.appTheme, @required this.onThemeChanged})
      : assert(onThemeChanged != null),
        super(key: key);

  final AppThemes appTheme;
  final ValueChanged<AppThemes> onThemeChanged;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _currentTitle;
  Widget _currentPage;
  int _currentIndex;

  LinkedHashMap<String, String> drawerItems() {
    LinkedHashMap<String, String> _map = new LinkedHashMap<String, String>();
    _map.addAll({'Settings': SettingsPage.routeName});

    return _map;
  }

  @override
  initState() {
    super.initState();

    _currentIndex = 0;
    _currentTitle = _pages().keys.toList()[_currentIndex];
    _currentPage = _pages()[_currentTitle];
  }

  // Start of pages
  static Widget _tweetsPage = new Center(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        /*             new Container(
                padding: EdgeInsets.only(top: 10.0),
                child: new Image(
                  image: new AssetImage('assets/images/PUBG_Header.png'),
                  width: 350.0,
                ),
              ),
              new Text(
                'Companion',
                style: AppTextStyles.headline,
              ),*/
        new FutureBuilder<List<Tweet>>(
          future: TwitterApi.fetchTweets(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new TweetsList(
                    tweets: snapshot.data,
                    scaffoldKey: _scaffoldKey,
                  )
                : new Container(
                    padding: EdgeInsets.only(top: 50.0),
                    child: new Center(child: new CircularProgressIndicator()),
                  );
          },
        ),
      ],
    ),
  );

  //TODO: Create model for drawer item and bottom item
  LinkedHashMap<String, Widget> _pages() {
    LinkedHashMap<String, Widget> _map = new LinkedHashMap<String, Widget>();
    _map.addAll({
      'News': _tweetsPage,
      'Weapons': new Center(
        child: new Text('TEST!'),
      )
    });

    return _map;
  }
  // End of pages

  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.ltr,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          title: new Container(
            padding: EdgeInsets.only(bottom: 5.0),
            child: new Text(
              _currentTitle,
              style: AppTextStyles.title,
            ),
          ),
        ),
        drawer: new Drawer(
          child: new ListView.builder(
            itemBuilder: (context, index) => new ListTile(
                  title: new Text(drawerItems().keys.toList()[index]),
                  subtitle: new Text('Item #' + index.toString()),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(
                        drawerItems()[drawerItems().keys.toList()[index]]);
                  },
                ),
            itemCount: drawerItems().length,
          ),
        ),
        body: _currentPage,
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _currentTitle = _pages().keys.toList()[index];
                _currentPage = _pages()[_currentTitle];
              });
            },
            items: [
              new BottomNavigationBarItem(
                title: new Text(_pages().keys.toList()[0]),
                icon: new Icon(FontAwesomeIcons.newspaper),
              ),
              new BottomNavigationBarItem(
                title: new Text(_pages().keys.toList()[1]),
                icon: new Icon(FontAwesomeIcons.crosshairs),
              ),
            ]),
      ),
    );
  }
}
