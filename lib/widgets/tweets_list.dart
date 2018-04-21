import 'dart:async';
import 'dart:convert';
import 'package:pubg_companion/api/twitter_api.dart';
import 'package:pubg_companion/models/link.dart';
import 'package:pubg_companion/utils/font_awesome_icon_data.dart';
import 'package:pubg_companion/utils/month_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pubg_companion/models/tweet.dart';
import 'package:transparent_image/transparent_image.dart';

class TweetsList extends StatefulWidget {
  final List<Tweet> tweets;
  final GlobalKey<ScaffoldState> scaffoldKey;

  TweetsList({Key key, this.tweets, this.scaffoldKey}) : super(key: key);

  @override
  _TweetsListState createState() =>
      new _TweetsListState(tweets: tweets, scaffoldKey: scaffoldKey);
}

class _TweetsListState extends State<TweetsList> {
  List<Tweet> tweets;
  final GlobalKey<ScaffoldState> scaffoldKey;

  _TweetsListState({this.tweets, this.scaffoldKey});

  Future<Null> _handleRefresh() async {
    Completer _completer = new Completer();

    tweets.clear();

    List<Tweet> _newTweets = await TwitterApi.fetchTweets();

    setState(() {
      tweets = _newTweets;
      scaffoldKey.currentState?.showSnackBar(
          new SnackBar(content: new Text('News feed updated successfully')));
    });

    return _completer.complete();
  }

  DateTime _parseDate(String tweetDate) {
    List<String> parts = tweetDate.split(' ');

    String _year = parts[5];
    String _month = MonthHandler.nameToNumber(parts[1]);
    String _day = parts[2];
    String _time = parts[3];

    DateTime finalDate =
        DateTime.parse(_year + '-' + _month + '-' + _day + ' ' + _time);

    DateTime utcDate = DateTime.utc(
        finalDate.year,
        finalDate.month,
        finalDate.day,
        finalDate.hour,
        finalDate.minute,
        finalDate.second,
        finalDate.microsecond);

    return utcDate;
  }

  Widget _displayDate(String tweetDate) {
    DateTime tweetLocalDate = _parseDate(tweetDate).toLocal();
    DateTime todayStart = new DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime yesterdayStart = todayStart.subtract(const Duration(days: 1));
    String str = '';

    if (tweetLocalDate.difference(DateTime.now()).inHours.abs() < 1) {
      str =
          tweetLocalDate.difference(DateTime.now()).inMinutes.abs().toString() +
              ' minutes ago';
    } else if (tweetLocalDate.isAfter(todayStart) ||
        tweetLocalDate.difference(DateTime.now()).inHours.abs() <= 12) {
      int hours =
          (DateTime.now().difference(tweetLocalDate).inMinutes / 60).round();
      str = hours.toString() + ' hours ago';
    } else if ((tweetLocalDate.isBefore(todayStart) &&
            tweetLocalDate.isAfter(yesterdayStart)) &&
        tweetLocalDate.difference(DateTime.now()).inHours.abs() > 12) {
      str = 'Yesterday';
    } else {
      String tweetHour = tweetLocalDate.hour > 9
          ? tweetLocalDate.hour.toString()
          : '0' + tweetLocalDate.hour.toString();

      String tweetMinute = tweetLocalDate.minute > 9
          ? tweetLocalDate.minute.toString()
          : '0' + tweetLocalDate.minute.toString();

      str = MonthHandler.numberToName(tweetLocalDate.month) +
          ' ' +
          tweetLocalDate.day.toString() +
          ', ' +
          tweetHour +
          ':' +
          tweetMinute;
    }

    return new Text(str);
  }

  Future<Link> _fetchLink(String url) async {
    final String key = '5acff9a6ac6f756e50467c8f9b2f27641d5f950c24eef';

    final response =
        await http.get('http://api.linkpreview.net/?key=$key&q=$url');
    final responseJson = json.decode(response.body);

    return new Link.fromJson(responseJson);
  }

  Widget _buildLinkContainer(BuildContext context, String _image, String _title,
      String _description, String _url) {
    if (_image.isNotEmpty) {
      return new Container(
        decoration:
            new BoxDecoration(border: Border.all(color: Colors.white30)),
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              color: Theme.of(context).accentColor,
              constraints: new BoxConstraints(maxHeight: 100.0),
              child: new FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: _image,
                //image: _image,
              ),
            ),
            new Expanded(
              child: new Container(
                constraints: new BoxConstraints(maxHeight: 100.0),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      _title,
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Theme.of(context).accentColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                    new Flexible(
                      child: new Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: new Text(
                          _description,
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1
                              .copyWith(fontWeight: FontWeight.w300),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return new Container(
        decoration: new BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor)),
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              color: Theme.of(context).accentColor,
              padding: EdgeInsets.all(10.0),
              constraints:
                  new BoxConstraints(maxHeight: 150.0, maxWidth: 150.0),
              child: new Icon(
                FontAwesomeIcons.link,
                size: 25.0,
                color: Theme.of(context).accentIconTheme.color,
              ),
            ),
            new Expanded(
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: new Center(
                    child: new Text(
                  _url,
                  style: Theme
                      .of(context)
                      .textTheme
                      .title
                      .copyWith(color: Theme.of(context).accentColor),
                )),
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _showTweetMedia(BuildContext context, List<TweetMedia> tweetMedia) {
    Widget _media;
    // TODO: return grid with multiple images if exists
    // TODO: check about missing images in some of the tweets
    List<String> urls = [];

    for (int i = 0; i < tweetMedia.length; i++) {
      if (tweetMedia[i].mediaType == 'photo') {
        urls.add(tweetMedia[i].mediaUrl);
      } else if (tweetMedia[i].mediaType == 'animated_gif' ||
          tweetMedia[i].mediaType == 'video') {
        urls.add(tweetMedia[i].mediaUrl);
      } else {
        print(tweetMedia[i].mediaType);
      }
    }

    if (tweetMedia[0].mediaType == 'photo') {
      _media = new FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: urls[0],
      );
    } else if (tweetMedia[0].mediaType == 'animated_gif' ||
        tweetMedia[0].mediaType == 'video') {
      _media = new Stack(
        children: <Widget>[
          new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage, image: urls[0]),
          new Positioned(
            top: 85.0,
            width: MediaQuery.of(context).size.width - 10,
            child: new Icon(
              FontAwesomeIcons.play,
              color: Theme.of(context).accentIconTheme.color,
              size: 50.0,
            ),
          )
        ],
      );
    }

    return new Container(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: _media,
    );
  }

  // Link Handling
  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  /*Future<Null> _launched;

  Future<Null> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<Null> snapshot) {
    if (snapshot.hasError) {
      return new Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }*/
  // End of link handling

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new RefreshIndicator(
      onRefresh: _handleRefresh,
      child: new ListView.builder(
        itemCount: tweets.length,
        itemBuilder: (context, index) {
          return new Column(children: <Widget>[
            new Tooltip(
              message: 'Show Tweet in Browser',
              child: new InkWell(
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      new ListTile(
                        title: _displayDate(tweets[index].createdAt),
                        subtitle: new Text(tweets[index].text),
                      ),
                      (tweets[index].tweetEntities.tweetUrls.length == 0 ||
                              tweets[index]
                                  .tweetEntities
                                  .tweetUrls[0]
                                  .expandedUrl
                                  .contains(tweets[index].idStr))
                          ? new Container(
                              height: 0.0,
                              width: 0.0,
                            )
                          : new FutureBuilder<Link>(
                              future: _fetchLink(
                                  tweets[index].tweetEntities.tweetUrls[0].url),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return new Tooltip(
                                    message: 'Open Link in Browser',
                                    child: new InkWell(
                                      onTap: () {
                                        _launchInBrowser(snapshot.data.url);
                                      },
                                      child: _buildLinkContainer(
                                          context,
                                          snapshot.data.image,
                                          snapshot.data.title,
                                          snapshot.data.description,
                                          tweets[index]
                                              .tweetEntities
                                              .tweetUrls[0]
                                              .url),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return new Text("${snapshot.error}");
                                }

                                // By default, show a loading spinner
                                return new CircularProgressIndicator();
                              },
                            ),
                      tweets[index].tweetExtendedEntities == null
                          ? new Container(
                              height: 0.0,
                              width: 0.0,
                            )
                          : _showTweetMedia(context,
                              tweets[index].tweetExtendedEntities.tweetMedia)
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    // TODO: replace 'PUBGMobile' with tweet actual username
                    _launchInBrowser('https://twitter.com/' +
                        'PUBGMobile' +
                        '/status/' +
                        tweets[index].idStr);
                  });
                },
              ),
            ),
            new Divider(
              height: 20.0,
            )
          ]);
        },
      ),
    ));
  }
}
