part of '../api.dart';

class SignupCommand {
  String fullName = null;

  String email = null;

  PhoneDto phone = null;

  LocationDto location = null;

  SignupCommand();

  @override
  String toString() {
    return 'SignupCommand[fullName=$fullName, email=$email, phone=$phone, location=$location, ]';
  }

  SignupCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    fullName = json['fullName'];
    email = json['email'];
    phone = new PhoneDto.fromJson(json['phone']);
    location = new LocationDto.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'location': location
    };
  }

  static List<SignupCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<SignupCommand>()
        : json.map((value) => new SignupCommand.fromJson(value)).toList();
  }

  static Map<String, SignupCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SignupCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SignupCommand.fromJson(value));
    }
    return map;
  }
}
