class Tweet {
  final String createdAt;
  final int id;
  final String idStr;
  final String text;
  final String inReplyToStatusIdStr;
  final String inReplyToUserIdStr;
  final TweetEntities tweetEntities;
  final TweetExtendedEntities tweetExtendedEntities;

  Tweet(
      {this.createdAt,
      this.id,
      this.idStr,
      this.text,
      this.inReplyToStatusIdStr,
      this.inReplyToUserIdStr,
      this.tweetEntities,
      this.tweetExtendedEntities});

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return new Tweet(
      createdAt: json['created_at'] as String,
      id: json['id'] as int,
      idStr: json['id_str'] as String,
      text: json['text'] as String,
      inReplyToStatusIdStr: json['in_reply_to_status_id_str'] as String,
      inReplyToUserIdStr: json['in_reply_to_user_id_str'] as String,
      tweetEntities: TweetEntities.fromJson(json['entities'] as Map),
      tweetExtendedEntities:
          TweetExtendedEntities.fromJson(json['extended_entities'] as Map),
    );
  }
}

class TweetEntities {
  final List<TweetUrls> tweetUrls;

  TweetEntities({this.tweetUrls});

  factory TweetEntities.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return new TweetEntities(tweetUrls: createTweetUrlsList(json['urls']));
  }

  static List<TweetUrls> createTweetUrlsList(List json) {
    if (json == null) return null;
    if (json.isEmpty) return [];

    return json
        .map((tweetUrlsJson) => TweetUrls.fromJson(tweetUrlsJson))
        .toList();
  }
}

class TweetExtendedEntities {
  final List<TweetMedia> tweetMedia;

  TweetExtendedEntities({this.tweetMedia});

  factory TweetExtendedEntities.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return new TweetExtendedEntities(
        tweetMedia: createTweetMediaList(json['media']));
  }

  static List<TweetMedia> createTweetMediaList(List json) {
    if (json == null) return null;
    if (json.isEmpty) return [];

    return json
        .map((tweetMediaJson) => TweetMedia.fromJson(tweetMediaJson))
        .toList();
  }
}

class TweetUrls {
  final String url;
  final String expandedUrl;

  TweetUrls({this.url, this.expandedUrl});

  factory TweetUrls.fromJson(Map<String, dynamic> json) {
    return new TweetUrls(
      url: json['url'] as String,
      expandedUrl: json['expanded_url'] as String,
    );
  }
}

class TweetMedia {
  final String mediaType;
  final String mediaUrl;

  TweetMedia({this.mediaType, this.mediaUrl});

  factory TweetMedia.fromJson(Map<String, dynamic> json) {
    return new TweetMedia(
      mediaType: json['type'] as String,
      mediaUrl: json['media_url'] as String,
    );
  }
}
