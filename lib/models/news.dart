class News {
  final String? title;
  final String? link;
  final String? keywords;
  final String? creator;
  final String? videoUrl;
  final String? description;
  final String? content;
  final String? pubDate;
  final String? imageUrl;
  final String? sourceId;
  final List<String>? country;
  final List<String>? category;
  final String? language;

  News(
      {required this.title,
      required this.link,
      required this.keywords,
      required this.creator,
      required this.videoUrl,
      required this.description,
      required this.content,
      required this.pubDate,
      required this.imageUrl,
      required this.sourceId,
      required this.country,
      required this.category,
      required this.language});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      link: json['link'],
      keywords: json['keywords'],
      creator: json['creator'],
      videoUrl: json['video_url'],
      description: json['description'],
      content: json['content'],
      pubDate: json['pubDate'],
      imageUrl: json['image_url'],
      sourceId: json['source_id'],
      country: json['country'].cast<String>(),
      category: json['category'].cast<String>(),
      language: json['language'],
    );
  }
}
