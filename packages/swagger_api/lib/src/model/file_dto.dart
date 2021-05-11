part of '../api.dart';

class FileDto {
  String id = null;

  String name = null;

  String contentType = null;

  String signedUrl = null;

  FileDto();

  @override
  String toString() {
    return 'FileDto[id=$id, name=$name, contentType=$contentType, signedUrl=$signedUrl, ]';
  }

  FileDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    contentType = json['contentType'];
    signedUrl = json['signedUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contentType': contentType,
      'signedUrl': signedUrl
    };
  }

  static List<FileDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<FileDto>()
        : json.map((value) => new FileDto.fromJson(value)).toList();
  }

  static Map<String, FileDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, FileDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new FileDto.fromJson(value));
    }
    return map;
  }
}
