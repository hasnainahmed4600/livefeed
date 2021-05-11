part of '../api.dart';

class CreateSignedUrlForFileUploadCommandResponseData {
  ApiResponse apiresponseMessage = null;

  FileDto data = null;

  CreateSignedUrlForFileUploadCommandResponseData();

  @override
  String toString() {
    return 'CreateSignedUrlForFileUploadCommandResponseData[apiresponseMessage=$apiresponseMessage, data=$data, ]';
  }

  CreateSignedUrlForFileUploadCommandResponseData.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    apiresponseMessage = new ApiResponse.fromJson(json['apiresponseMessage']);
    data = new FileDto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiresponseMessage': apiresponseMessage, 'data': data};
  }

  static List<CreateSignedUrlForFileUploadCommandResponseData> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<CreateSignedUrlForFileUploadCommandResponseData>()
        : json
            .map((value) =>
                new CreateSignedUrlForFileUploadCommandResponseData.fromJson(
                    value))
            .toList();
  }

  static Map<String, CreateSignedUrlForFileUploadCommandResponseData>
      mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map =
        new Map<String, CreateSignedUrlForFileUploadCommandResponseData>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new CreateSignedUrlForFileUploadCommandResponseData.fromJson(value));
    }
    return map;
  }
}
