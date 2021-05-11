part of '../api.dart';

class UserProfilePostDto {
  String id = null;

  DateTime createdOn = null;

  String headline = null;

  String category = null;

  UserProfilePostDto();

  @override
  String toString() {
    return 'UserProfilePostDto[id=$id, createdOn=$createdOn, headline=$headline, category=$category, ]';
  }

  UserProfilePostDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    createdOn =
        json['createdOn'] == null ? null : DateTime.parse(json['createdOn']);
    headline = json['headline'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdOn': createdOn == null ? '' : createdOn.toUtc().toIso8601String(),
      'headline': headline,
      'category': category
    };
  }

  static List<UserProfilePostDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserProfilePostDto>()
        : json.map((value) => new UserProfilePostDto.fromJson(value)).toList();
  }

  static Map<String, UserProfilePostDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserProfilePostDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserProfilePostDto.fromJson(value));
    }
    return map;
  }
}
