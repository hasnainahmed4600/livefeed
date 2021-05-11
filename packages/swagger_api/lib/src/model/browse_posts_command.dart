part of '../api.dart';

class BrowsePostsCommand {
  List<String> postIds = [];

  BrowsePostsCommand();

  @override
  String toString() {
    return 'BrowsePostsCommand[postIds=$postIds, ]';
  }

  BrowsePostsCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    postIds = (json['postIds'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'postIds': postIds};
  }

  static List<BrowsePostsCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<BrowsePostsCommand>()
        : json.map((value) => new BrowsePostsCommand.fromJson(value)).toList();
  }

  static Map<String, BrowsePostsCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, BrowsePostsCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new BrowsePostsCommand.fromJson(value));
    }
    return map;
  }
}
