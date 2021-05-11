part of '../api.dart';

class SignupCommandResponseData {
  ApiResponse apiresponseMessage = null;

  SignupCommandResponseDataData data = null;

  SignupCommandResponseData();

  @override
  String toString() {
    return 'SignupCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  SignupCommandResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new SignupCommandResponseDataData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<SignupCommandResponseData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<SignupCommandResponseData>()
        : json
            .map((value) => new SignupCommandResponseData.fromJson(value))
            .toList();
  }

  static Map<String, SignupCommandResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SignupCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SignupCommandResponseData.fromJson(value));
    }
    return map;
  }
}
