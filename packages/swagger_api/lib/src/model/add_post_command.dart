part of '../api.dart';

class AddPostCommand {
  String headline = null;

  String description = null;

  String categoryId = null;

  List<String> uploadedFileIds = [];

  LocationDto location = null;

  AddPostCommand();

  @override
  String toString() {
    return 'AddPostCommand[headline=$headline, description=$description, categoryId=$categoryId, uploadedFileIds=$uploadedFileIds, location=$location, ]';
  }

  AddPostCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    headline = json['headline'];
    description = json['description'];
    categoryId = json['categoryId'];
    uploadedFileIds = (json['uploadedFileIds'] as List)
        .map((item) => item as String)
        .toList();
    location = new LocationDto.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    return {
      'headline': headline,
      'description': description,
      'categoryId': categoryId,
      'uploadedFileIds': uploadedFileIds,
      'location': location
    };
  }

  static List<AddPostCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AddPostCommand>()
        : json.map((value) => new AddPostCommand.fromJson(value)).toList();
  }

  static Map<String, AddPostCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddPostCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AddPostCommand.fromJson(value));
    }
    return map;
  }
}
