part of '../api.dart';

class CreateSignedUrlForFileUploadCommand {
  String fileName = null;

/* Content type property for the bucket object as specified here https://cloud.google.com/storage/docs/json_api/v1/objects#resource */
  String contentType = null;

  CreateSignedUrlForFileUploadCommand();

  @override
  String toString() {
    return 'CreateSignedUrlForFileUploadCommand[fileName=$fileName, contentType=$contentType, ]';
  }

  CreateSignedUrlForFileUploadCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    fileName = json['fileName'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    return {'fileName': fileName, 'contentType': contentType};
  }

  static List<CreateSignedUrlForFileUploadCommand> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<CreateSignedUrlForFileUploadCommand>()
        : json
            .map((value) =>
                new CreateSignedUrlForFileUploadCommand.fromJson(value))
            .toList();
  }

  static Map<String, CreateSignedUrlForFileUploadCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateSignedUrlForFileUploadCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateSignedUrlForFileUploadCommand.fromJson(value));
    }
    return map;
  }
}
