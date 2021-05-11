part of '../api.dart';

class RelatedPostDto {
  String id = null;

  FileDto thumbnail = null;

/* The date and time that the contribution was created on */
  String postedOn = null;

  CategoryDto category = null;

  String headline = null;

  RelatedPostDto();

  @override
  String toString() {
    return 'RelatedPostDto[id=$id, thumbnail=$thumbnail, postedOn=$postedOn, category=$category, headline=$headline, ]';
  }

  RelatedPostDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    thumbnail = new FileDto.fromJson(json['thumbnail']);
    postedOn = json['postedOn'];
    category = new CategoryDto.fromJson(json['category']);
    headline = json['headline'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'postedOn': postedOn,
      'category': category,
      'headline': headline
    };
  }

  static List<RelatedPostDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RelatedPostDto>()
        : json.map((value) => new RelatedPostDto.fromJson(value)).toList();
  }

  static Map<String, RelatedPostDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RelatedPostDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RelatedPostDto.fromJson(value));
    }
    return map;
  }
}
