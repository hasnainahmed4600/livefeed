part of '../api.dart';

class PatchAdvertisementCommand {
  bool toDelete = null;

  bool toActivateDeactivate = null;

  PatchAdvertisementCommand();

  @override
  String toString() {
    return 'PatchAdvertisementCommand[toDelete=$toDelete, toActivateDeactivate=$toActivateDeactivate, ]';
  }

  PatchAdvertisementCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    toDelete = json['toDelete'];
    toActivateDeactivate = json['toActivateDeactivate'];
  }

  Map<String, dynamic> toJson() {
    return {'toDelete': toDelete, 'toActivateDeactivate': toActivateDeactivate};
  }

  static List<PatchAdvertisementCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PatchAdvertisementCommand>()
        : json
            .map((value) => new PatchAdvertisementCommand.fromJson(value))
            .toList();
  }

  static Map<String, PatchAdvertisementCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PatchAdvertisementCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PatchAdvertisementCommand.fromJson(value));
    }
    return map;
  }
}
