part of '../api.dart';

class EditPostCommandResponseData {
  ApiResponse apiresponseMessage = null;

  PostDto data = null;

  EditPostCommandResponseData();

  @override
  String toString() {
    return 'EditPostCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  EditPostCommandResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new PostDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<EditPostCommandResponseData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<EditPostCommandResponseData>()
        : json
            .map((value) => new EditPostCommandResponseData.fromJson(value))
            .toList();
  }

  static Map<String, EditPostCommandResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, EditPostCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EditPostCommandResponseData.fromJson(value));
    }
    return map;
  }
}
