part of '../api.dart';

class AddPostCommandResponseData {
  ApiResponse apiresponseMessage = null;

  PostDto data = null;

  AddPostCommandResponseData();

  @override
  String toString() {
    return 'AddPostCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  AddPostCommandResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new PostDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<AddPostCommandResponseData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AddPostCommandResponseData>()
        : json
            .map((value) => new AddPostCommandResponseData.fromJson(value))
            .toList();
  }

  static Map<String, AddPostCommandResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddPostCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AddPostCommandResponseData.fromJson(value));
    }
    return map;
  }
}
