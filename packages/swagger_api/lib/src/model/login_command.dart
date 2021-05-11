part of '../api.dart';

class LoginCommand {
  PhoneDto phone = null;

  LoginCommand();

  @override
  String toString() {
    return 'LoginCommand[phone=$phone, ]';
  }

  LoginCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    phone = new PhoneDto.fromJson(json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'phone': phone};
  }

  static List<LoginCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<LoginCommand>()
        : json.map((value) => new LoginCommand.fromJson(value)).toList();
  }

  static Map<String, LoginCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, LoginCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new LoginCommand.fromJson(value));
    }
    return map;
  }
}
