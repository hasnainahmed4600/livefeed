part of '../api.dart';

class GetAdvertisementsListQueryResponseData {
  ApiResponse apiresponseMessage = null;

  List<AdvertisementDto> data = [];

  GetAdvertisementsListQueryResponseData();

  @override
  String toString() {
    return 'GetAdvertisementsListQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetAdvertisementsListQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = AdvertisementDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetAdvertisementsListQueryResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetAdvertisementsListQueryResponseData>()
        : json
            .map((value) =>
                new GetAdvertisementsListQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetAdvertisementsListQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetAdvertisementsListQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new GetAdvertisementsListQueryResponseData.fromJson(value));
    }
    return map;
  }
}
