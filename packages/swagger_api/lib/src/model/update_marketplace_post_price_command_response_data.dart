part of '../api.dart';

class UpdateMarketplacePostPriceCommandResponseData {
  ApiResponse apiresponseMessage = null;

  MarketplacePostDto data = null;

  UpdateMarketplacePostPriceCommandResponseData();

  @override
  String toString() {
    return 'UpdateMarketplacePostPriceCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  UpdateMarketplacePostPriceCommandResponseData.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new MarketplacePostDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<UpdateMarketplacePostPriceCommandResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<UpdateMarketplacePostPriceCommandResponseData>()
        : json
            .map((value) =>
                new UpdateMarketplacePostPriceCommandResponseData.fromJson(
                    value))
            .toList();
  }

  static Map<String, UpdateMarketplacePostPriceCommandResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateMarketplacePostPriceCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new UpdateMarketplacePostPriceCommandResponseData.fromJson(value));
    }
    return map;
  }
}
