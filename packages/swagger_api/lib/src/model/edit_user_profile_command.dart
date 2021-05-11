part of '../api.dart';

class EditUserProfileCommand {
  String name = null;

  String profilePictureFileId = null;

  String email = null;

  PhoneDto phone = null;

  LocationDto location = null;

  UserProfileDtoInterests interests = null;

  EditUserProfileCommand();

  @override
  String toString() {
    return 'EditUserProfileCommand[name=$name, profilePictureFileId=$profilePictureFileId, email=$email, phone=$phone, location=$location, interests=$interests, ]';
  }

  EditUserProfileCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    profilePictureFileId = json['profilePictureFileId'];
    email = json['email'];
    phone = new PhoneDto.fromJson(json['phone']);
    location = new LocationDto.fromJson(json['location']);
    interests = new UserProfileDtoInterests.fromJson(json['interests']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profilePictureFileId': profilePictureFileId,
      'email': email,
      'phone': phone,
      'location': location,
      'interests': interests
    };
  }

  static List<EditUserProfileCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<EditUserProfileCommand>()
        : json
            .map((value) => new EditUserProfileCommand.fromJson(value))
            .toList();
  }

  static Map<String, EditUserProfileCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, EditUserProfileCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EditUserProfileCommand.fromJson(value));
    }
    return map;
  }
}
