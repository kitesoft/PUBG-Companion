import 'dart:async';
import 'dart:convert';

import 'package:pubg_companion/models/tweet.dart';
import 'package:twitter/twitter.dart';

class TwitterApi{
  static Future<List<Tweet>> fetchTweets() async {
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

  static List<Tweet> parseTweets(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed.map<Tweet>((json) => new Tweet.fromJson(json)).toList();
  }
}