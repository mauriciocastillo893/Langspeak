import 'dart:convert';

ChapterUserContent chapterUserContentFromJson(String str) => ChapterUserContent.fromJson(json.decode(str));

String chapterUserContentToJson(ChapterUserContent data) => json.encode(data.toJson());

class ChapterUserContent {
  final int season;
  final String seasonName;
  final String chapterName;
  final String motto;
  final List<Content> content;

  ChapterUserContent({
    required this.season,
    required this.seasonName,
    required this.chapterName,
    required this.motto,
    required this.content,
  });

  factory ChapterUserContent.fromJson(Map<String, dynamic> json) => ChapterUserContent(
        season: json["season"],
        seasonName: json["seasonName"],
        chapterName: json["chapterName"],
        motto: json["motto"],
        content: json["content"] != null
            ? List<Content>.from(json["content"].map((x) => Content.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "season": season,
        "seasonName": seasonName,
        "chapterName": chapterName,
        "motto": motto,
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class Content {
  final String title;
  final String subtitle;
  final List<UrlResource> urlResources;

  Content({
    required this.title,
    required this.subtitle,
    required this.urlResources,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        title: json["title"],
        subtitle: json["subtitle"],
        urlResources: json["url_resources"] != null
            ? List<UrlResource>.from(json["url_resources"].map((x) => UrlResource.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "url_resources": List<dynamic>.from(urlResources.map((x) => x.toJson())),
      };
}

class UrlResource {
  final String url;

  UrlResource({
    required this.url,
  });

  factory UrlResource.fromJson(Map<String, dynamic> json) => UrlResource(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
