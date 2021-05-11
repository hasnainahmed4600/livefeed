part of '../api.dart';

class SignupCommandResponseDataData {
  /* This uniquely identifies the login event against which the user will need to verify */
  String verificationEventId = null;

  SignupCommandResponseDataData();

  @override
  String toString() {
    return 'SignupCommandResponseDataData[verificationEventId=$verificationEventId, ]';
  }

  SignupCommandResponseDataData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    verificationEventId = json['verificationEventId'];
  }

  Map<String, dynamic> toJson() {
    return {'verificationEventId': verificationEventId};
  }

  static List<SignupCommandResponseDataData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<SignupCommandResponseDataData>()
        : json
            .map((value) => new SignupCommandResponseDataData.fromJson(value))
            .toList();
  }

  static Map<String, SignupCommandResponseDataData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SignupCommandResponseDataData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SignupCommandResponseDataData.fromJson(value));
    }
    return map;
  }
}
