part of '../api.dart';

class GetSignedUrlForFileReadQuery {
  String fileId = null;

  GetSignedUrlForFileReadQuery();

  @override
  String toString() {
    return 'GetSignedUrlForFileReadQuery[fileId=$fileId, ]';
  }

  GetSignedUrlForFileReadQuery.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    fileId = json['fileId'];
  }

  Map<String, dynamic> toJson() {
    return {'fileId': fileId};
  }

  static List<GetSignedUrlForFileReadQuery> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<GetSignedUrlForFileReadQuery>()
        : json
            .map((value) => new GetSignedUrlForFileReadQuery.fromJson(value))
            .toList();
  }

  static Map<String, GetSignedUrlForFileReadQuery> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetSignedUrlForFileReadQuery>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetSignedUrlForFileReadQuery.fromJson(value));
    }
    return map;
  }
}
