part of '../api.dart';

class MarketplacePostListItemDto {
  String id = null;

  String authorName = null;

  FileDto authorPicture = null;

/* The date and time that the post was created on */
  String postedOn = null;

  String headline = null;

  String description = null;

  PostPriceDto price = null;

  bool isMediaVideo = null;

/* Will be supplied only is isMediaVideo == true */
  FileDto videoFile = null;

  FileDto videoThumbnail = null;

  FileDto imageFile = null;

  MarketplacePostListItemDto();

  @override
  String toString() {
    return 'MarketplacePostListItemDto[id=$id, authorName=$authorName, authorPicture=$authorPicture, postedOn=$postedOn, headline=$headline, description=$description, price=$price, isMediaVideo=$isMediaVideo, videoFile=$videoFile, videoThumbnail=$videoThumbnail, imageFile=$imageFile, ]';
  }

  MarketplacePostListItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    authorName = json['authorName'];
    authorPicture = new FileDto.fromJson(json['authorPicture']);
    postedOn = json['postedOn'];
    headline = json['headline'];
    description = json['description'];
    price = new PostPriceDto.fromJson(json['price']);
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
      'price': price,
      'isMediaVideo': isMediaVideo,
      'videoFile': videoFile,
      'videoThumbnail': videoThumbnail,
      'imageFile': imageFile
    };
  }

  static List<MarketplacePostListItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MarketplacePostListItemDto>()
        : json
            .map((value) => new MarketplacePostListItemDto.fromJson(value))
            .toList();
  }

  static Map<String, MarketplacePostListItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MarketplacePostListItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MarketplacePostListItemDto.fromJson(value));
    }
    return map;
  }
}
