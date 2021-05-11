part of '../api.dart';

class GetLiveFeedPostsListQueryResponseData {
  ApiResponse apiresponseMessage = null;

  PostListItemDto data = null;

  GetLiveFeedPostsListQueryResponseData();

  @override
  String toString() {
    return 'GetLiveFeedPostsListQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetLiveFeedPostsListQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new PostListItemDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetLiveFeedPostsListQueryResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetLiveFeedPostsListQueryResponseData>()
        : json
            .map((value) =>
                new GetLiveFeedPostsListQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetLiveFeedPostsListQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetLiveFeedPostsListQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetLiveFeedPostsListQueryResponseData.fromJson(value));
    }
    return map;
  }
}
