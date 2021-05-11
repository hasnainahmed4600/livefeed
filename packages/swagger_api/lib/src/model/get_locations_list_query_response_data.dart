part of '../api.dart';

class GetLocationsListQueryResponseData {
  ApiResponse apiresponseMessage = null;

  List<LocationDto> data = [];

  GetLocationsListQueryResponseData();

  @override
  String toString() {
    return 'GetLocationsListQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetLocationsListQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = LocationDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetLocationsListQueryResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetLocationsListQueryResponseData>()
        : json
            .map((value) =>
                new GetLocationsListQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetLocationsListQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetLocationsListQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetLocationsListQueryResponseData.fromJson(value));
    }
    return map;
  }
}
