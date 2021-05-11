part of '../api.dart';

class CategoryDto {
  String id = null;

  String name = null;

  CategoryDto();

  @override
  String toString() {
    return 'CategoryDto[id=$id, name=$name, ]';
  }

  CategoryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  static List<CategoryDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CategoryDto>()
        : json.map((value) => new CategoryDto.fromJson(value)).toList();
  }

  static Map<String, CategoryDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CategoryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CategoryDto.fromJson(value));
    }
    return map;
  }
}
