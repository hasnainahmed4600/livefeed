part of '../api.dart';

class PostPriceDto {
  String currency = null;

  String currencySymbol = null;

  double value = null;

  PostPriceDto();

  @override
  String toString() {
    return 'PostPriceDto[currency=$currency, currencySymbol=$currencySymbol, value=$value, ]';
  }

  PostPriceDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    currency = json['currency'];
    currencySymbol = json['currencySymbol'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'currencySymbol': currencySymbol,
      'value': value
    };
  }

  static List<PostPriceDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PostPriceDto>()
        : json.map((value) => new PostPriceDto.fromJson(value)).toList();
  }

  static Map<String, PostPriceDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PostPriceDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PostPriceDto.fromJson(value));
    }
    return map;
  }
}
