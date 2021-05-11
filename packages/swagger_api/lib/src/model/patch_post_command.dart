part of '../api.dart';

class PatchPostCommand {
  bool toSeePost = null;

  bool toMoveToMarketplace = null;

  PatchPostCommand();

  @override
  String toString() {
    return 'PatchPostCommand[toSeePost=$toSeePost, toMoveToMarketplace=$toMoveToMarketplace, ]';
  }

  PatchPostCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    toSeePost = json['toSeePost'];
    toMoveToMarketplace = json['toMoveToMarketplace'];
  }

  Map<String, dynamic> toJson() {
    return {'toSeePost': toSeePost, 'toMoveToMarketplace': toMoveToMarketplace};
  }

  static List<PatchPostCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PatchPostCommand>()
        : json.map((value) => new PatchPostCommand.fromJson(value)).toList();
  }

  static Map<String, PatchPostCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PatchPostCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PatchPostCommand.fromJson(value));
    }
    return map;
  }
}
