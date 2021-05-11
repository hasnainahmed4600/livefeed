part of '../api.dart';

class GetPostsListQueryResponseDataData {
  int adOffset = null;

  PostListItemDto posts = null;

  List<AdPosterDto> ads = [];

  GetPostsListQueryResponseDataData();

  @override
  String toString() {
    return 'GetPostsListQueryResponseDataData[adOffset=$adOffset, posts=$posts, ads=$ads, ]';
  }

  GetPostsListQueryResponseDataData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    adOffset = json['adOffset'];
    posts = new PostListItemDto.fromJson(json['posts']);
    ads = AdPosterDto.listFromJson(json['ads']);
  }

  Map<String, dynamic> toJson() {
    return {'adOffset': adOffset, 'posts': posts, 'ads': ads};
  }

  static List<GetPostsListQueryResponseDataData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetPostsListQueryResponseDataData>()
        : json
            .map((value) =>
                new GetPostsListQueryResponseDataData.fromJson(value))
            .toList();
  }

  static Map<String, GetPostsListQueryResponseDataData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetPostsListQueryResponseDataData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetPostsListQueryResponseDataData.fromJson(value));
    }
    return map;
  }
}
