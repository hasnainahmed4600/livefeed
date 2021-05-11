part of '../api.dart';

class AddAdvertisementCommandResponseData {
  ApiResponse apiresponseMessage = null;

  AdvertisementDto data = null;

  AddAdvertisementCommandResponseData();

  @override
  String toString() {
    return 'AddAdvertisementCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  AddAdvertisementCommandResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new AdvertisementDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<AddAdvertisementCommandResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<AddAdvertisementCommandResponseData>()
        : json
            .map((value) =>
                new AddAdvertisementCommandResponseData.fromJson(value))
            .toList();
  }

  static Map<String, AddAdvertisementCommandResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddAdvertisementCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AddAdvertisementCommandResponseData.fromJson(value));
    }
    return map;
  }
}
