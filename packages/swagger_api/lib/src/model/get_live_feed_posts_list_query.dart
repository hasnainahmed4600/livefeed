part of '../api.dart';

class GetLiveFeedPostsListQuery {
  int skip = null;

  int take = null;

  GetLiveFeedPostsListQuery();

  @override
  String toString() {
    return 'GetLiveFeedPostsListQuery[skip=$skip, take=$take, ]';
  }

  GetLiveFeedPostsListQuery.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    skip = json['skip'];
    take = json['take'];
  }

  Map<String, dynamic> toJson() {
    return {'skip': skip, 'take': take};
  }

  static List<GetLiveFeedPostsListQuery> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<GetLiveFeedPostsListQuery>()
        : json
            .map((value) => new GetLiveFeedPostsListQuery.fromJson(value))
            .toList();
  }

  static Map<String, GetLiveFeedPostsListQuery> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetLiveFeedPostsListQuery>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetLiveFeedPostsListQuery.fromJson(value));
    }
    return map;
  }
}
