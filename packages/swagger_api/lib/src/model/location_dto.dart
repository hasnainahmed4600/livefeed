part of '../api.dart';

class LocationDto {
  String address = null;

  String zipCode = null;

  LocationDto();

  @override
  String toString() {
    return 'LocationDto[address=$address, zipCode=$zipCode, ]';
  }

  LocationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    address = json['address'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'zipCode': zipCode};
  }

  static List<LocationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<LocationDto>()
        : json.map((value) => new LocationDto.fromJson(value)).toList();
  }

  static Map<String, LocationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, LocationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new LocationDto.fromJson(value));
    }
    return map;
  }
}
