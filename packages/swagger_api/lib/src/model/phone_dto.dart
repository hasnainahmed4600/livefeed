part of '../api.dart';

class PhoneDto {
  String phoneCountryCodeNo = null;

  String phoneCountryIsoCode = null;

  String phoneNumber = null;

  PhoneDto();

  @override
  String toString() {
    return 'PhoneDto[phoneCountryCodeNo=$phoneCountryCodeNo, phoneCountryIsoCode=$phoneCountryIsoCode, phoneNumber=$phoneNumber, ]';
  }

  PhoneDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    phoneCountryCodeNo = json['phoneCountryCodeNo'];
    phoneCountryIsoCode = json['phoneCountryIsoCode'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneCountryCodeNo': phoneCountryCodeNo,
      'phoneCountryIsoCode': phoneCountryIsoCode,
      'phoneNumber': phoneNumber
    };
  }

  static List<PhoneDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PhoneDto>()
        : json.map((value) => new PhoneDto.fromJson(value)).toList();
  }

  static Map<String, PhoneDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PhoneDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PhoneDto.fromJson(value));
    }
    return map;
  }
}
