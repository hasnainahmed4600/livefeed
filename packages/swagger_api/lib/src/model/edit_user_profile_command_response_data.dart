part of '../api.dart';

class EditUserProfileCommandResponseData {
  ApiResponse apiresponseMessage = null;

  UserProfileDto data = null;

  EditUserProfileCommandResponseData();

  @override
  String toString() {
    return 'EditUserProfileCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  EditUserProfileCommandResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new UserProfileDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<EditUserProfileCommandResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<EditUserProfileCommandResponseData>()
        : json
            .map((value) =>
                new EditUserProfileCommandResponseData.fromJson(value))
            .toList();
  }

  static Map<String, EditUserProfileCommandResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, EditUserProfileCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EditUserProfileCommandResponseData.fromJson(value));
    }
    return map;
  }
}
