part of '../api.dart';

class AddMarketplacePostCommand {
  String headline = null;

  String description = null;

  String categoryId = null;

  List<String> uploadedFileIds = [];

  LocationDto location = null;

  AddMarketplacePostCommand();

  @override
  String toString() {
    return 'AddMarketplacePostCommand[headline=$headline, description=$description, categoryId=$categoryId, uploadedFileIds=$uploadedFileIds, location=$location, ]';
  }

  AddMarketplacePostCommand.fromJson(Map<String, dynamic> json) {
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

  static List<AddMarketplacePostCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AddMarketplacePostCommand>()
        : json
            .map((value) => new AddMarketplacePostCommand.fromJson(value))
            .toList();
  }

  static Map<String, AddMarketplacePostCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddMarketplacePostCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AddMarketplacePostCommand.fromJson(value));
    }
    return map;
  }
}
