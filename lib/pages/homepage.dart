import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pubg_companion/models/drawer_item.dart';
import 'package:pubg_companion/pages/news.dart';
import 'package:pubg_companion/pages/settings.dart';
import 'package:pubg_companion/utils/app_text_styles.dart';
import 'package:pubg_companion/utils/app_themes.dart';
import 'package:pubg_companion/utils/font_awesome_icon_data.dart';
import 'package:pubg_companion/utils/govicons_icon_data.dart';

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

  List<DrawerNavigationItem> _drawerItems = [
    new DrawerNavigationItem(title: 'Test', routeName: SettingsPage.routeName),
    new DrawerNavigationItem(
        title: 'Settings',
        routeName: SettingsPage.routeName,
        description: 'Settings description',
        icon: new Icon(FontAwesomeIcons.cog))
  ];

  @override
  initState() {
    super.initState();

    _currentIndex = 0;
    _currentTitle = _pages[_currentIndex].title;
    _currentPage = _pages[_currentIndex].pageWidget;
  }

  // Start of pages
  static Widget _tweetsPage = NewsPag(
    scaffoldKey: _scaffoldKey,
  );

  List<BottomNavigationItem> _pages = [
    new BottomNavigationItem(
        title: 'News',
        pageWidget: _tweetsPage,
        icon: new Icon(FontAwesomeIcons.newspaper)),
    new BottomNavigationItem(
        title: 'Weapons',
        pageWidget: new Center(child: new Text('WEAPONS!!!')),
        icon: new Icon(GovIcons.gun)),
  ];

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
                  leading: new CircleAvatar(
                    child: _drawerItems[index].icon ??
                        new Text(_drawerItems[index].title[0].toUpperCase()),
                  ),
                  title: new Text(_drawerItems[index].title),
                  subtitle: new Text(_drawerItems[index].description ?? ''),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator
                        .of(context)
                        .pushNamed(_drawerItems[index].routeName);
                  },
                ),
            itemCount: _drawerItems.length,
          ),
        ),
        body: _currentPage,
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _currentTitle = _pages[index].title;
                _currentPage = _pages[index].pageWidget;
              });
            },
            items: _pages
                .map((page) => new BottomNavigationBarItem(
                    title: new Text(page.title), icon: page.icon))
                .toList()),
      ),
    );
  }
}
