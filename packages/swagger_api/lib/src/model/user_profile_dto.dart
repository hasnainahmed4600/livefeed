part of '../api.dart';

class UserProfileDto {
  String id = null;

  String imageUrl = null;

  String fullName = null;

  double liveFeedRating = null;

  String email = null;

  LocationDto location = null;

  PhoneDto phone = null;

  UserProfileDtoInterests interests = null;

  UserProfileDto();

  @override
  String toString() {
    return 'UserProfileDto[id=$id, imageUrl=$imageUrl, fullName=$fullName, liveFeedRating=$liveFeedRating, email=$email, location=$location, phone=$phone, interests=$interests, ]';
  }

  UserProfileDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    imageUrl = json['imageUrl'];
    fullName = json['fullName'];
    liveFeedRating = json['liveFeedRating'];
    email = json['email'];
    location = new LocationDto.fromJson(json['location']);
    phone = new PhoneDto.fromJson(json['phone']);
    interests = new UserProfileDtoInterests.fromJson(json['interests']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'fullName': fullName,
      'liveFeedRating': liveFeedRating,
      'email': email,
      'location': location,
      'phone': phone,
      'interests': interests
    };
  }

  static List<UserProfileDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserProfileDto>()
        : json.map((value) => new UserProfileDto.fromJson(value)).toList();
  }

  static Map<String, UserProfileDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserProfileDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserProfileDto.fromJson(value));
    }
    return map;
  }
}
