part of '../api.dart';

class GetCategoryListQueryResponseData {
  ApiResponse apiresponseMessage = null;

  List<CategoryDto> data = [];

  GetCategoryListQueryResponseData();

  @override
  String toString() {
    return 'GetCategoryListQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetCategoryListQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = CategoryDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetCategoryListQueryResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetCategoryListQueryResponseData>()
        : json
            .map(
                (value) => new GetCategoryListQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetCategoryListQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetCategoryListQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetCategoryListQueryResponseData.fromJson(value));
    }
    return map;
  }
}
