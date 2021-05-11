part of '../api.dart';

class MarketplacePostDto {
  String id = null;

  String authorName = null;

  FileDto authorPicture = null;

/* The date and time that the post was created on */
  String postedOn = null;

  LocationDto location = null;

  CategoryDto category = null;

  double liveFeedRating = null;

  String headline = null;

  String description = null;

  PostPriceDto price = null;

  List<FileDto> mediaFiles = [];

  int likes = null;

  int dislikes = null;

  String userReaction = null;
  //enum userReactionEnum {  none,  liked,  disliked,  };

  String shareLink = null;

  AdPosterDto advertisement = null;

  List<PostContributionDto> contributionPosts = [];

  List<RelatedPostDto> relatedPosts = [];

  MarketplacePostDto();

  @override
  String toString() {
    return 'MarketplacePostDto[id=$id, authorName=$authorName, authorPicture=$authorPicture, postedOn=$postedOn, location=$location, category=$category, liveFeedRating=$liveFeedRating, headline=$headline, description=$description, price=$price, mediaFiles=$mediaFiles, likes=$likes, dislikes=$dislikes, userReaction=$userReaction, shareLink=$shareLink, advertisement=$advertisement, contributionPosts=$contributionPosts, relatedPosts=$relatedPosts, ]';
  }

  MarketplacePostDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    authorName = json['authorName'];
    authorPicture = new FileDto.fromJson(json['authorPicture']);
    postedOn = json['postedOn'];
    location = new LocationDto.fromJson(json['location']);
    category = new CategoryDto.fromJson(json['category']);
    liveFeedRating = json['liveFeedRating'];
    headline = json['headline'];
    description = json['description'];
    price = new PostPriceDto.fromJson(json['price']);
    mediaFiles = FileDto.listFromJson(json['mediaFiles']);
    likes = json['likes'];
    dislikes = json['dislikes'];
    userReaction = json['userReaction'];
    shareLink = json['shareLink'];
    advertisement = new AdPosterDto.fromJson(json['advertisement']);
    contributionPosts =
        PostContributionDto.listFromJson(json['contributionPosts']);
    relatedPosts = RelatedPostDto.listFromJson(json['relatedPosts']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorPicture': authorPicture,
      'postedOn': postedOn,
      'location': location,
      'category': category,
      'liveFeedRating': liveFeedRating,
      'headline': headline,
      'description': description,
      'price': price,
      'mediaFiles': mediaFiles,
      'likes': likes,
      'dislikes': dislikes,
      'userReaction': userReaction,
      'shareLink': shareLink,
      'advertisement': advertisement,
      'contributionPosts': contributionPosts,
      'relatedPosts': relatedPosts
    };
  }

  static List<MarketplacePostDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MarketplacePostDto>()
        : json.map((value) => new MarketplacePostDto.fromJson(value)).toList();
  }

  static Map<String, MarketplacePostDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MarketplacePostDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MarketplacePostDto.fromJson(value));
    }
    return map;
  }
}
