import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pubg_companion/models/tweet.dart';
import 'package:pubg_companion/pages/settings.dart';
import 'package:pubg_companion/utils/app_text_styles.dart';
import 'package:pubg_companion/utils/app_themes.dart';
import 'package:pubg_companion/widgets/tweets_list.dart';
import 'package:twitter/twitter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.appTheme, @required this.onThemeChanged})
      : assert(onThemeChanged != null),
        super(key: key);

  final String title;
  final AppThemes appTheme;
  final ValueChanged<AppThemes> onThemeChanged;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final key = new GlobalKey<ScaffoldState>();

  Future<List<Tweet>> fetchTweets() async {
    final Twitter twitter = new Twitter(
        '4y9EBqgIt1quyWEOkof6PTJS8',
        'shBFHm3UvuJ3HN8rYhUFMYQAYnKDutktTCZKGAbVo5oKTMjYZ1',
        '48317927-8ABvYyRU18QmtD1DXLvJvzESk8NEpqOwDNyTK85mT',
        'qlrMy7x7gy0CHS2K1Y2SXOdaTctrrTz73o0DjXdPuZ2lo');

    var response = await twitter.request("GET",
        "statuses/user_timeline.json?screen_name=PUBGMOBILE&count=200&include_rts=false&exclude_replies=true");

    print(response.body.substring(100));
    return parseTweets(response.body);
  }

  List<Tweet> parseTweets(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed.map<Tweet>((json) => new Tweet.fromJson(json)).toList();
  }

  LinkedHashMap<String, String> drawerItems() {
    LinkedHashMap<String, String> _map = new LinkedHashMap<String,String>();
    _map.addAll({'Settings': SettingsPage.routeName});

    return _map;
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.ltr,
      child: new Scaffold(
        drawer: new Drawer(
          child: new ListView.builder(
            itemBuilder: (context, index) => new ListTile(
                  title: new Text(drawerItems().keys.toList()[index]),
                  subtitle: new Text('Item #' + index.toString()),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        drawerItems()[drawerItems().keys.toList()[index]]);
                  },
                ),
            itemCount: drawerItems().length,
          ),
        ),
        appBar: new AppBar(
          elevation: 0.0,
          title: new Container(
            padding: EdgeInsets.only(bottom: 5.0),
            child: new Text(
              widget.title,
              style: AppTextStyles.title,
            ),
          ),
        ),
        body: new Center(
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
                future: fetchTweets(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? new TweetsList(tweets: snapshot.data)
                      : new Container(
                          padding: EdgeInsets.only(top: 50.0),
                          child: new Center(
                              child: new CircularProgressIndicator()),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
