part of '../api.dart';

class AddFeedbackCommand {
  String name = null;

  String email = null;

  String body = null;

  AddFeedbackCommand();

  @override
  String toString() {
    return 'AddFeedbackCommand[name=$name, email=$email, body=$body, ]';
  }

  AddFeedbackCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'body': body};
  }

  static List<AddFeedbackCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AddFeedbackCommand>()
        : json.map((value) => new AddFeedbackCommand.fromJson(value)).toList();
  }

  static Map<String, AddFeedbackCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddFeedbackCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AddFeedbackCommand.fromJson(value));
    }
    return map;
  }
}
