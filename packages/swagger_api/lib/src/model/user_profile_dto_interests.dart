part of '../api.dart';

class UserProfileDtoInterests {
  List<UserProfileInterestDto> interests = [];

  List<LocationDto> locations = [];

  UserProfileDtoInterests();

  @override
  String toString() {
    return 'UserProfileDtoInterests[interests=$interests, locations=$locations, ]';
  }

  UserProfileDtoInterests.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    interests = UserProfileInterestDto.listFromJson(json['interests']);
    locations = LocationDto.listFromJson(json['locations']);
  }

  Map<String, dynamic> toJson() {
    return {'interests': interests, 'locations': locations};
  }

  static List<UserProfileDtoInterests> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserProfileDtoInterests>()
        : json
            .map((value) => new UserProfileDtoInterests.fromJson(value))
            .toList();
  }

  static Map<String, UserProfileDtoInterests> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserProfileDtoInterests>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserProfileDtoInterests.fromJson(value));
    }
    return map;
  }
}
