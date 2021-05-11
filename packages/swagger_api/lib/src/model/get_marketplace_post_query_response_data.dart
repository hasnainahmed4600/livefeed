part of '../api.dart';

class GetMarketplacePostQueryResponseData {
  ApiResponse apiresponseMessage = null;

  MarketplacePostDto data = null;

  GetMarketplacePostQueryResponseData();

  @override
  String toString() {
    return 'GetMarketplacePostQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetMarketplacePostQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new MarketplacePostDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetMarketplacePostQueryResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetMarketplacePostQueryResponseData>()
        : json
            .map((value) =>
                new GetMarketplacePostQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetMarketplacePostQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetMarketplacePostQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetMarketplacePostQueryResponseData.fromJson(value));
    }
    return map;
  }
}
