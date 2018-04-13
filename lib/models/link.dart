class Link {
  final String title;
  final String description;
  final String image;
  final String url;

  Link({this.title, this.description, this.image, this.url});

  factory Link.fromJson(Map<String, dynamic> json) {
    return new Link(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      url: json['url'],
    );
  }
}
