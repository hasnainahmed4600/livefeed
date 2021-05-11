part of '../api.dart';

class GetPostsListQueryResponseData {
  ApiResponse apiresponseMessage = null;

  GetPostsListQueryResponseDataData data = null;

  GetPostsListQueryResponseData();

  @override
  String toString() {
    return 'GetPostsListQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetPostsListQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new GetPostsListQueryResponseDataData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetPostsListQueryResponseData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<GetPostsListQueryResponseData>()
        : json
            .map((value) => new GetPostsListQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetPostsListQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetPostsListQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetPostsListQueryResponseData.fromJson(value));
    }
    return map;
  }
}
