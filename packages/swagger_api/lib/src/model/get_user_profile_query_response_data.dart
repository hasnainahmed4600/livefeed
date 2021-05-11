part of '../api.dart';

class GetUserProfileQueryResponseData {
  ApiResponse apiresponseMessage = null;

  UserProfileDto data = null;

  GetUserProfileQueryResponseData();

  @override
  String toString() {
    return 'GetUserProfileQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetUserProfileQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new UserProfileDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetUserProfileQueryResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetUserProfileQueryResponseData>()
        : json
            .map((value) => new GetUserProfileQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetUserProfileQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetUserProfileQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetUserProfileQueryResponseData.fromJson(value));
    }
    return map;
  }
}
