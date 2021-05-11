part of '../api.dart';

class GetPostsListQuery {
  String keywordFilter = null;

/* Ids of the categories to filter on */
  List<String> categoriesFilter = [];

  LocationDto locationFilter = null;

  int skip = null;

  int take = null;

  GetPostsListQuery();

  @override
  String toString() {
    return 'GetPostsListQuery[keywordFilter=$keywordFilter, categoriesFilter=$categoriesFilter, locationFilter=$locationFilter, skip=$skip, take=$take, ]';
  }

  GetPostsListQuery.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    keywordFilter = json['keywordFilter'];
    categoriesFilter = (json['categoriesFilter'] as List)
        .map((item) => item as String)
        .toList();
    locationFilter = new LocationDto.fromJson(json['locationFilter']);
    skip = json['skip'];
    take = json['take'];
  }

  Map<String, dynamic> toJson() {
    return {
      'keywordFilter': keywordFilter,
      'categoriesFilter': categoriesFilter,
      'locationFilter': locationFilter,
      'skip': skip,
      'take': take
    };
  }

  static List<GetPostsListQuery> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<GetPostsListQuery>()
        : json.map((value) => new GetPostsListQuery.fromJson(value)).toList();
  }

  static Map<String, GetPostsListQuery> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetPostsListQuery>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetPostsListQuery.fromJson(value));
    }
    return map;
  }
}
