part of '../api.dart';

class EditPostCommand {
  String headline = null;

  String description = null;

  String categoryId = null;

  List<String> uploadedFileIds = [];

  LocationDto location = null;

  EditPostCommand();

  @override
  String toString() {
    return 'EditPostCommand[headline=$headline, description=$description, categoryId=$categoryId, uploadedFileIds=$uploadedFileIds, location=$location, ]';
  }

  EditPostCommand.fromJson(Map<String, dynamic> json) {
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

  static List<EditPostCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<EditPostCommand>()
        : json.map((value) => new EditPostCommand.fromJson(value)).toList();
  }

  static Map<String, EditPostCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, EditPostCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EditPostCommand.fromJson(value));
    }
    return map;
  }
}
