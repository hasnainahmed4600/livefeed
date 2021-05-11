part of '../api.dart';

class GetUserProfilePostsQueryResponseData {
  ApiResponse apiresponseMessage = null;

  List<UserProfilePostDto> data = [];

  GetUserProfilePostsQueryResponseData();

  @override
  String toString() {
    return 'GetUserProfilePostsQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetUserProfilePostsQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = UserProfilePostDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetUserProfilePostsQueryResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetUserProfilePostsQueryResponseData>()
        : json
            .map((value) =>
                new GetUserProfilePostsQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetUserProfilePostsQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetUserProfilePostsQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetUserProfilePostsQueryResponseData.fromJson(value));
    }
    return map;
  }
}
