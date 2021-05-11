part of '../api.dart';

class VerifyCommand {
  ApiResponse apiresponseMessage = null;

  VerifyCommandData data = null;

  VerifyCommand();

  @override
  String toString() {
    return 'VerifyCommand[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  VerifyCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new VerifyCommandData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<VerifyCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<VerifyCommand>()
        : json.map((value) => new VerifyCommand.fromJson(value)).toList();
  }

  static Map<String, VerifyCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, VerifyCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new VerifyCommand.fromJson(value));
    }
    return map;
  }
}
