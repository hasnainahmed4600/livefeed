part of '../api.dart';

class ResendVerificationCodeCommand {
  String verificationEventId = null;

  ResendVerificationCodeCommand();

  @override
  String toString() {
    return 'ResendVerificationCodeCommand[verificationEventId=$verificationEventId, ]';
  }

  ResendVerificationCodeCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    verificationEventId = json['verificationEventId'];
  }

  Map<String, dynamic> toJson() {
    return {'verificationEventId': verificationEventId};
  }

  static List<ResendVerificationCodeCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ResendVerificationCodeCommand>()
        : json
            .map((value) => new ResendVerificationCodeCommand.fromJson(value))
            .toList();
  }

  static Map<String, ResendVerificationCodeCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ResendVerificationCodeCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ResendVerificationCodeCommand.fromJson(value));
    }
    return map;
  }
}
