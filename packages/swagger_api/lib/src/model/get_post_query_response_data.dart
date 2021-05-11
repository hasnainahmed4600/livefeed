part of '../api.dart';

class GetPostQueryResponseData {
  ApiResponse apiresponseMessage = null;

  PostDto data = null;

  GetPostQueryResponseData();

  @override
  String toString() {
    return 'GetPostQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetPostQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new PostDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetPostQueryResponseData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<GetPostQueryResponseData>()
        : json
            .map((value) => new GetPostQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetPostQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetPostQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetPostQueryResponseData.fromJson(value));
    }
    return map;
  }
}
