part of '../api.dart';

class GetMarketplacePostsListQuery {
  String keywordFilter = null;

/* Ids of the categories to filter on */
  List<String> categoriesFilter = [];

  LocationDto locationFilter = null;

  int skip = null;

  int take = null;

  GetMarketplacePostsListQuery();

  @override
  String toString() {
    return 'GetMarketplacePostsListQuery[keywordFilter=$keywordFilter, categoriesFilter=$categoriesFilter, locationFilter=$locationFilter, skip=$skip, take=$take, ]';
  }

  GetMarketplacePostsListQuery.fromJson(Map<String, dynamic> json) {
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

  static List<GetMarketplacePostsListQuery> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<GetMarketplacePostsListQuery>()
        : json
            .map((value) => new GetMarketplacePostsListQuery.fromJson(value))
            .toList();
  }

  static Map<String, GetMarketplacePostsListQuery> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetMarketplacePostsListQuery>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetMarketplacePostsListQuery.fromJson(value));
    }
    return map;
  }
}
