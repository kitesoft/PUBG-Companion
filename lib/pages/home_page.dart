import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pubg_companion/models/drawer_item.dart';
import 'package:pubg_companion/pages/news_page.dart';
import 'package:pubg_companion/pages/settings_page.dart';
import 'package:pubg_companion/pages/weapons_page.dart';
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

  static String sortRadioValue;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _currentTitle;
  Widget _currentPage;
  int _currentIndex;

  void _handleSortChanged(String value) {
    setState(() {
      HomePage.sortRadioValue = value;
    });
  }

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

    HomePage.sortRadioValue = 'name';
  }

  // Start of pages
  static Widget _tweetsPage = NewsPage(
    scaffoldKey: _scaffoldKey,
  );

  static Widget _weaponsPage = WeaponsPage(
    scaffoldKey: _scaffoldKey,
  );

  List<BottomNavigationItem> _pages = [
    new BottomNavigationItem(
        title: 'News',
        pageWidget: _tweetsPage,
        icon: new Icon(FontAwesomeIcons.newspaper)),
    new BottomNavigationItem(
        title: 'Weapons',
        pageWidget: _weaponsPage,
        icon: new Icon(GovIcons.gun)),
  ];
  // End of pages

  void _showSortDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
            'Sorting weapons by ' + value.toString().toLowerCase(),
          ),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.ltr,
      child: new DefaultTabController(
        length: weaponFamilies.length,
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
          floatingActionButton: _currentIndex == 1
              ? new FloatingActionButton(
                  child: new Icon(FontAwesomeIcons.sort_amount_up),
                  onPressed: () {
                    _showSortDialog<String>(
                        context: context,
                        child: new SimpleDialog(
                            title: const Text('Sort weapons by...'),
                            children: <Widget>[
                              new SimpleDialogOption(
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Radio<String>(
                                      value: 'name',
                                      groupValue: HomePage.sortRadioValue,
                                      onChanged: _handleSortChanged,
                                    ),
                                    new Icon(FontAwesomeIcons.sort_alpha_down,
                                        size: 20.0,
                                        color: Theme.of(context).accentColor),
                                    new Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: new Text(
                                        'Name',
                                        style: AppTextStyles.weaponsSortOption,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    HomePage.sortRadioValue = 'name';
                                  });
                                  Navigator.pop(context, 'Name');
                                },
                              ),
                              new SimpleDialogOption(
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Radio<String>(
                                      value: 'damage',
                                      groupValue: HomePage.sortRadioValue,
                                      onChanged: _handleSortChanged,
                                    ),
                                    new Icon(GovIcons.poison,
                                        size: 20.0,
                                        color: Theme.of(context).accentColor),
                                    new Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: new Text(
                                        'Damage',
                                        style: AppTextStyles.weaponsSortOption,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    HomePage.sortRadioValue = 'damage';
                                  });

                                  Navigator.pop(context, 'Damage');
                                },
                              ),
                            ]));
                  },
                )
              : null,
        ),
      ),
    );
  }
}
