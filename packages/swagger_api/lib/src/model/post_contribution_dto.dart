part of '../api.dart';

class PostContributionDto {
  String id = null;

  String authorName = null;

  FileDto authorPicture = null;

/* The date and time that the contribution was created on */
  String postedOn = null;

  LocationDto location = null;

  String headline = null;

  PostContributionDto();

  @override
  String toString() {
    return 'PostContributionDto[id=$id, authorName=$authorName, authorPicture=$authorPicture, postedOn=$postedOn, location=$location, headline=$headline, ]';
  }

  PostContributionDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    authorName = json['authorName'];
    authorPicture = new FileDto.fromJson(json['authorPicture']);
    postedOn = json['postedOn'];
    location = new LocationDto.fromJson(json['location']);
    headline = json['headline'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorPicture': authorPicture,
      'postedOn': postedOn,
      'location': location,
      'headline': headline
    };
  }

  static List<PostContributionDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PostContributionDto>()
        : json.map((value) => new PostContributionDto.fromJson(value)).toList();
  }

  static Map<String, PostContributionDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PostContributionDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PostContributionDto.fromJson(value));
    }
    return map;
  }
}
