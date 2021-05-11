part of '../api.dart';

class VerifyCommandResponseData {
  ApiResponse apiresponseMessage = null;

  VerifyCommandResponseDataData data = null;

  VerifyCommandResponseData();

  @override
  String toString() {
    return 'VerifyCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  VerifyCommandResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new VerifyCommandResponseDataData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<VerifyCommandResponseData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<VerifyCommandResponseData>()
        : json
            .map((value) => new VerifyCommandResponseData.fromJson(value))
            .toList();
  }

  static Map<String, VerifyCommandResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, VerifyCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new VerifyCommandResponseData.fromJson(value));
    }
    return map;
  }
}
