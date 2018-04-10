import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pubg_companion/pages/settings.dart';
import 'package:pubg_companion/utils/app_themes.dart';
import 'package:pubg_companion/utils/font_awesome_icon_data.dart';

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
  int _counter = 0;

  List<String> drawerItems = ['A', 'B', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.ltr,
        child: new Scaffold(
          drawer: new Drawer(
            child: new ListView.builder(
              itemBuilder: (context, index) => new ListTile(
                    title: new Text(drawerItems[index]),
                    subtitle: new Text('Item #' + index.toString()),
                    onTap: () {},
                  ),
              itemCount: drawerItems.length,
            ),
          ),
          appBar: new AppBar(
            elevation: 0.0,
            title: new Text(widget.title),
          ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'You have pushed the button this many times:',
                ),
                new Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, SettingsPage.routeName);
            },
            tooltip: 'Increment',
            child: new Icon(FontAwesomeIcons.cog),
          ),
        ));
  }
}
