part of '../api.dart';

class PostListItemDto {
  String id = null;

  String authorName = null;

  FileDto authorPicture = null;

/* The date and time that the post was created on */
  String postedOn = null;

  String headline = null;

  String description = null;

/* Has the user already seen this post? */
  bool seen = null;

  bool isMediaVideo = null;

/* Will be supplied only is isMediaVideo == true */
  FileDto videoFile = null;

  FileDto videoThumbnail = null;

  FileDto imageFile = null;

  PostListItemDto();

  @override
  String toString() {
    return 'PostListItemDto[id=$id, authorName=$authorName, authorPicture=$authorPicture, postedOn=$postedOn, headline=$headline, description=$description, seen=$seen, isMediaVideo=$isMediaVideo, videoFile=$videoFile, videoThumbnail=$videoThumbnail, imageFile=$imageFile, ]';
  }

  PostListItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    authorName = json['authorName'];
    authorPicture = new FileDto.fromJson(json['authorPicture']);
    postedOn = json['postedOn'];
    headline = json['headline'];
    description = json['description'];
    seen = json['seen'];
    isMediaVideo = json['isMediaVideo'];
    videoFile = new FileDto.fromJson(json['videoFile']);
    videoThumbnail = new FileDto.fromJson(json['videoThumbnail']);
    imageFile = new FileDto.fromJson(json['imageFile']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorPicture': authorPicture,
      'postedOn': postedOn,
      'headline': headline,
      'description': description,
      'seen': seen,
      'isMediaVideo': isMediaVideo,
      'videoFile': videoFile,
      'videoThumbnail': videoThumbnail,
      'imageFile': imageFile
    };
  }

  static List<PostListItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PostListItemDto>()
        : json.map((value) => new PostListItemDto.fromJson(value)).toList();
  }

  static Map<String, PostListItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PostListItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PostListItemDto.fromJson(value));
    }
    return map;
  }
}
