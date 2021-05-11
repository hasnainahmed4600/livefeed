part of '../api.dart';

class AdPosterDto {
  String id = null;

  FileDto posterImage = null;

  AdPosterDto();

  @override
  String toString() {
    return 'AdPosterDto[id=$id, posterImage=$posterImage, ]';
  }

  AdPosterDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    posterImage = new FileDto.fromJson(json['posterImage']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'posterImage': posterImage};
  }

  static List<AdPosterDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AdPosterDto>()
        : json.map((value) => new AdPosterDto.fromJson(value)).toList();
  }

  static Map<String, AdPosterDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AdPosterDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AdPosterDto.fromJson(value));
    }
    return map;
  }
}
