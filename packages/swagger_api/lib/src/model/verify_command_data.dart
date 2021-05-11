part of '../api.dart';

class VerifyCommandData {
  /* Verification event id that was supplied as a response for login or signup commands */
  String verificationEventId = null;

  String verificationCode = null;

  VerifyCommandData();

  @override
  String toString() {
    return 'VerifyCommandData[verificationEventId=$verificationEventId, verificationCode=$verificationCode, ]';
  }

  VerifyCommandData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    verificationEventId = json['verificationEventId'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'verificationEventId': verificationEventId,
      'verificationCode': verificationCode
    };
  }

  static List<VerifyCommandData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<VerifyCommandData>()
        : json.map((value) => new VerifyCommandData.fromJson(value)).toList();
  }

  static Map<String, VerifyCommandData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, VerifyCommandData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new VerifyCommandData.fromJson(value));
    }
    return map;
  }
}
