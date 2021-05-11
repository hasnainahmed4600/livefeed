part of '../api.dart';

class LoginCommandResponseData {
  ApiResponse apiresponseMessage = null;

  SignupCommandResponseDataData data = null;

  LoginCommandResponseData();

  @override
  String toString() {
    return 'LoginCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  LoginCommandResponseData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new SignupCommandResponseDataData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<LoginCommandResponseData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<LoginCommandResponseData>()
        : json
            .map((value) => new LoginCommandResponseData.fromJson(value))
            .toList();
  }

  static Map<String, LoginCommandResponseData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, LoginCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new LoginCommandResponseData.fromJson(value));
    }
    return map;
  }
}
