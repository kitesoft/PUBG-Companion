import 'package:flutter/material.dart';
import 'package:pubg_companion/api/twitter_api.dart';
import 'package:pubg_companion/models/tweet.dart';
import 'package:pubg_companion/widgets/tweets_list.dart';

class NewsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  NewsPage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _NewsPageState createState() => new _NewsPageState(scaffoldKey: scaffoldKey);
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _NewsPageState({this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new FutureBuilder<List<Tweet>>(
            future: TwitterApi.fetchTweets(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? new TweetsList(
                      tweets: snapshot.data,
                      scaffoldKey: scaffoldKey,
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
  }
}
