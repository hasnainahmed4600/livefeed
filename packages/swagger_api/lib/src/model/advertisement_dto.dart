part of '../api.dart';

class AdvertisementDto {
  String id = null;

  String targetMarket = null;
  //enum targetMarketEnum {  worldwide,  local,  hyperlocal,  };

  String targetView = null;
  //enum targetViewEnum {  post,  timeline,  both,  };

  FileDto posterFile = null;

  AdvertisementDto();

  @override
  String toString() {
    return 'AdvertisementDto[id=$id, targetMarket=$targetMarket, targetView=$targetView, posterFile=$posterFile, ]';
  }

  AdvertisementDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    targetMarket = json['targetMarket'];
    targetView = json['targetView'];
    posterFile = new FileDto.fromJson(json['posterFile']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'targetMarket': targetMarket,
      'targetView': targetView,
      'posterFile': posterFile
    };
  }

  static List<AdvertisementDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AdvertisementDto>()
        : json.map((value) => new AdvertisementDto.fromJson(value)).toList();
  }

  static Map<String, AdvertisementDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AdvertisementDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AdvertisementDto.fromJson(value));
    }
    return map;
  }
}
