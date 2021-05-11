part of '../api.dart';

class GetUserProfilePostsQuery {
  int skip = null;

  int take = null;

  GetUserProfilePostsQuery();

  @override
  String toString() {
    return 'GetUserProfilePostsQuery[skip=$skip, take=$take, ]';
  }

  GetUserProfilePostsQuery.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    skip = json['skip'];
    take = json['take'];
  }

  Map<String, dynamic> toJson() {
    return {'skip': skip, 'take': take};
  }

  static List<GetUserProfilePostsQuery> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<GetUserProfilePostsQuery>()
        : json
            .map((value) => new GetUserProfilePostsQuery.fromJson(value))
            .toList();
  }

  static Map<String, GetUserProfilePostsQuery> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetUserProfilePostsQuery>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetUserProfilePostsQuery.fromJson(value));
    }
    return map;
  }
}
