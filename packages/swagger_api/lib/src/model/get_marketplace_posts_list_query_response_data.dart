part of '../api.dart';

class GetMarketplacePostsListQueryResponseData {
  ApiResponse apiresponseMessage = null;

  MarketplacePostListItemDto data = null;

  GetMarketplacePostsListQueryResponseData();

  @override
  String toString() {
    return 'GetMarketplacePostsListQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetMarketplacePostsListQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new MarketplacePostListItemDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetMarketplacePostsListQueryResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetMarketplacePostsListQueryResponseData>()
        : json
            .map((value) =>
                new GetMarketplacePostsListQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetMarketplacePostsListQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetMarketplacePostsListQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new GetMarketplacePostsListQueryResponseData.fromJson(value));
    }
    return map;
  }
}
