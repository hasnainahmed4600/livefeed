part of '../api.dart';

class AddMarketplacePostCommandResponseData {
  ApiResponse apiresponseMessage = null;

  MarketplacePostDto data = null;

  AddMarketplacePostCommandResponseData();

  @override
  String toString() {
    return 'AddMarketplacePostCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  AddMarketplacePostCommandResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new MarketplacePostDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<AddMarketplacePostCommandResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<AddMarketplacePostCommandResponseData>()
        : json
            .map((value) =>
                new AddMarketplacePostCommandResponseData.fromJson(value))
            .toList();
  }

  static Map<String, AddMarketplacePostCommandResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddMarketplacePostCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AddMarketplacePostCommandResponseData.fromJson(value));
    }
    return map;
  }
}
