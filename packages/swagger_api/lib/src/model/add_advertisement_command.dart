part of '../api.dart';

class AddAdvertisementCommand {
  String targetMarket = null;
  //enum targetMarketEnum {  worldwide,  local,  hyperlocal,  };

  String targetView = null;
  //enum targetViewEnum {  post,  timeline,  both,  };

  String assistedDesignDescription = null;

  String assistedDesignFileId = null;

  String selfDesignFileId = null;

  AddAdvertisementCommand();

  @override
  String toString() {
    return 'AddAdvertisementCommand[targetMarket=$targetMarket, targetView=$targetView, assistedDesignDescription=$assistedDesignDescription, assistedDesignFileId=$assistedDesignFileId, selfDesignFileId=$selfDesignFileId, ]';
  }

  AddAdvertisementCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    targetMarket = json['targetMarket'];
    targetView = json['targetView'];
    assistedDesignDescription = json['assistedDesignDescription'];
    assistedDesignFileId = json['assistedDesignFileId'];
    selfDesignFileId = json['selfDesignFileId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'targetMarket': targetMarket,
      'targetView': targetView,
      'assistedDesignDescription': assistedDesignDescription,
      'assistedDesignFileId': assistedDesignFileId,
      'selfDesignFileId': selfDesignFileId
    };
  }

  static List<AddAdvertisementCommand> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AddAdvertisementCommand>()
        : json
            .map((value) => new AddAdvertisementCommand.fromJson(value))
            .toList();
  }

  static Map<String, AddAdvertisementCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AddAdvertisementCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AddAdvertisementCommand.fromJson(value));
    }
    return map;
  }
}
