part of '../api.dart';

class PostNotificationDto {
  int unseenPosts = null;

  List<PostListItemDto> newPosts = [];

  PostNotificationDto();

  @override
  String toString() {
    return 'PostNotificationDto[unseenPosts=$unseenPosts, newPosts=$newPosts, ]';
  }

  PostNotificationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    unseenPosts = json['unseenPosts'];
    newPosts = PostListItemDto.listFromJson(json['newPosts']);
  }

  Map<String, dynamic> toJson() {
    return {'unseenPosts': unseenPosts, 'newPosts': newPosts};
  }

  static List<PostNotificationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PostNotificationDto>()
        : json.map((value) => new PostNotificationDto.fromJson(value)).toList();
  }

  static Map<String, PostNotificationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PostNotificationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PostNotificationDto.fromJson(value));
    }
    return map;
  }
}
