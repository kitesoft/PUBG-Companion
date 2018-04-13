import 'dart:async';
import 'dart:convert';
import 'package:pubg_companion/models/link.dart';
import 'package:pubg_companion/utils/font_awesome_icon_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pubg_companion/models/tweet.dart';
import 'package:transparent_image/transparent_image.dart';

class TweetsList extends StatelessWidget {
  final List<Tweet> tweets;

  TweetsList({Key key, this.tweets}) : super(key: key);

  DateTime _parseDate(String twitterDate) {
    List<String> parts = twitterDate.split(' ');

    String _year = parts[5];
    String _month;
    String _day = parts[2];
    String _time = parts[3];

    switch (parts[1]) {
      case 'Jan':
        _month = '01';
        break;
      case 'Feb':
        _month = '02';
        break;
      case 'Mar':
        _month = '03';
        break;
      case 'Apr':
        _month = '04';
        break;
      case 'May':
        _month = '05';
        break;
      case 'Jun':
        _month = '06';
        break;
      case 'Jul':
        _month = '07';
        break;
      case 'Aug':
        _month = '08';
        break;
      case 'Sep':
        _month = '09';
        break;
      case 'Oct':
        _month = '10';
        break;
      case 'Nov':
        _month = '11';
        break;
      case 'Dec':
        _month = '12';
        break;
      default:
        _month = '01';
        break;
    }

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
              padding: EdgeInsets.all(10.0),
              constraints:
                  new BoxConstraints(maxHeight: 100.0, maxWidth: 100.0),
              child: new FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                    _image,
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .title
                          .copyWith(color: Theme.of(context).accentColor),
                    ),
                    new Flexible(
                      child: new Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: new Text(
                          _description,
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
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
        decoration:
            new BoxDecoration(border: Border.all(color: Colors.white30)),
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

  Widget _showTweetMedia(List<TweetMedia> tweetMedia) {
    // TODO: return grid with multiple images if exists
    List<String> urls = [];

    for (int i = 0; i < tweetMedia.length; i++) {
      // TODO: check about videos
      if (tweetMedia[i].mediaType == 'photo') {
        urls.add(tweetMedia[i].mediaUrl);
      } else {
        print(tweetMedia[i].mediaType);
      }
    }

    return new Container(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: new FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: urls[0],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new ListView.builder(
      itemCount: tweets.length,
      itemBuilder: (context, index) {
        return new Column(children: <Widget>[
          new ListTile(
            title: _parseDate(tweets[index].createdAt)
                        .difference(DateTime.now().toUtc())
                        .inHours >
                    -24
                ? _parseDate(tweets[index].createdAt)
                            .difference(DateTime.now().toUtc())
                            .inHours >
                        -2
                    ? new Text(_parseDate(tweets[index].createdAt)
                            .difference(DateTime.now().toUtc())
                            .inMinutes
                            .abs()
                            .toString() +
                        ' minutes ago')
                    : new Text(_parseDate(tweets[index].createdAt)
                            .difference(DateTime.now().toUtc())
                            .inHours
                            .abs()
                            .toString() +
                        ' hours ago')
                : new Text(
                    _parseDate(tweets[index].createdAt).toLocal().toString()),
            subtitle: new Text(tweets[index].text),
          ),
          tweets[index].tweetEntities.tweetUrls.length == 0
              ? new Container(
                  height: 0.0,
                  width: 0.0,
                )
              : new FutureBuilder<Link>(
                  future:
                      _fetchLink(tweets[index].tweetEntities.tweetUrls[0].url),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _buildLinkContainer(
                          context,
                          snapshot.data.image,
                          snapshot.data.title,
                          snapshot.data.description,
                          tweets[index].tweetEntities.tweetUrls[0].url);
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
              : _showTweetMedia(tweets[index].tweetExtendedEntities.tweetMedia),
          new Divider(
            height: 20.0,
          )
        ]);
      },
    ));
  }
}
