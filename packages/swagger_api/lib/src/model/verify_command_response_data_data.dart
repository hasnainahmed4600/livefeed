part of '../api.dart';

class VerifyCommandResponseDataData {
  /* Access token that needs to be supplied as a Bearer token in Authorization header for every secured endpoint */
  String jwtBearerToken = null;

  UserProfileDto userProfileDto = null;

  VerifyCommandResponseDataData();

  @override
  String toString() {
    return 'VerifyCommandResponseDataData[jwtBearerToken=$jwtBearerToken, userProfileDto=$userProfileDto, ]';
  }

  VerifyCommandResponseDataData.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    jwtBearerToken = json['jwtBearerToken'];
    userProfileDto = new UserProfileDto.fromJson(json['UserProfileDto']);
  }

  Map<String, dynamic> toJson() {
    return {'jwtBearerToken': jwtBearerToken, 'UserProfileDto': userProfileDto};
  }

  static List<VerifyCommandResponseDataData> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<VerifyCommandResponseDataData>()
        : json
            .map((value) => new VerifyCommandResponseDataData.fromJson(value))
            .toList();
  }

  static Map<String, VerifyCommandResponseDataData> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, VerifyCommandResponseDataData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new VerifyCommandResponseDataData.fromJson(value));
    }
    return map;
  }
}
