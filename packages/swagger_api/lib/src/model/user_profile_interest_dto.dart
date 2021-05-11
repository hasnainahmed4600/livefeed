part of '../api.dart';

class UserProfileInterestDto {
  String id = null;

  String title = null;

  UserProfileInterestDto();

  @override
  String toString() {
    return 'UserProfileInterestDto[id=$id, title=$title, ]';
  }

  UserProfileInterestDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }

  static List<UserProfileInterestDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserProfileInterestDto>()
        : json
            .map((value) => new UserProfileInterestDto.fromJson(value))
            .toList();
  }

  static Map<String, UserProfileInterestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserProfileInterestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserProfileInterestDto.fromJson(value));
    }
    return map;
  }
}
