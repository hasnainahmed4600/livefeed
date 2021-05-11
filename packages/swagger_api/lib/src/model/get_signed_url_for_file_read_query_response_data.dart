part of '../api.dart';

class GetSignedUrlForFileReadQueryResponseData {
  ApiResponse apiresponseMessage = null;

  FileDto data = null;

  GetSignedUrlForFileReadQueryResponseData();

  @override
  String toString() {
    return 'GetSignedUrlForFileReadQueryResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  GetSignedUrlForFileReadQueryResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new FileDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<GetSignedUrlForFileReadQueryResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<GetSignedUrlForFileReadQueryResponseData>()
        : json
            .map((value) =>
                new GetSignedUrlForFileReadQueryResponseData.fromJson(value))
            .toList();
  }

  static Map<String, GetSignedUrlForFileReadQueryResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetSignedUrlForFileReadQueryResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new GetSignedUrlForFileReadQueryResponseData.fromJson(value));
    }
    return map;
  }
}
