// To parse this JSON data, do
//
//     final newsEntry = newsEntryFromJson(jsonString);

import 'dart:convert';

List<NewsEntry> newsEntryFromJson(String str) => List<NewsEntry>.from(json.decode(str).map((x) => NewsEntry.fromJson(x)));

String newsEntryToJson(List<NewsEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsEntry {
  String id;
  String title;
  String content;
  Category category;
  String? thumbnail;
  int newsViews;
  DateTime createdAt;
  bool isFeatured;
  int? userId;

  NewsEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.thumbnail,
    required this.newsViews,
    required this.createdAt,
    required this.isFeatured,
    required this.userId,
  });

  factory NewsEntry.fromJson(Map<String, dynamic> json) => NewsEntry(
    id: json["id"]?.toString() ?? "",
    title: json["title"] ?? "",
    content: json["content"] ?? "",
    category: categoryValues.map[json["category"]] ?? Category.UPDATE,
    thumbnail: json["thumbnail"] ?? "",
    newsViews: json["news_views"] ?? 0,
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    isFeatured: json["is_featured"] ?? false,
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "category": categoryValues.reverse[category],
    "thumbnail": thumbnail,
    "news_views": newsViews,
    "created_at": createdAt.toIso8601String(),
    "is_featured": isFeatured,
    "user_id": userId,
  };
}

enum Category {
  RUMOR,
  TRANSFER,
  UPDATE
}

final categoryValues = EnumValues({
  "rumor": Category.RUMOR,
  "transfer": Category.TRANSFER,
  "update": Category.UPDATE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
