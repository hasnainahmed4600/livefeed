part of '../api.dart';

class PostDto {
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

  List<FileDto> mediaFiles = [];

  int likes = null;

  int dislikes = null;

  String userReaction = null;
  //enum userReactionEnum {  none,  liked,  disliked,  };
/* Has the user already seen this post? */
  bool seen = null;

  String shareLink = null;

  AdPosterDto advertisement = null;

  List<PostContributionDto> contributionPosts = [];

  List<RelatedPostDto> relatedPosts = [];

  PostDto();

  @override
  String toString() {
    return 'PostDto[id=$id, authorName=$authorName, authorPicture=$authorPicture, postedOn=$postedOn, location=$location, category=$category, liveFeedRating=$liveFeedRating, headline=$headline, description=$description, mediaFiles=$mediaFiles, likes=$likes, dislikes=$dislikes, userReaction=$userReaction, seen=$seen, shareLink=$shareLink, advertisement=$advertisement, contributionPosts=$contributionPosts, relatedPosts=$relatedPosts, ]';
  }

  PostDto.fromJson(Map<String, dynamic> json) {
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
    mediaFiles = FileDto.listFromJson(json['mediaFiles']);
    likes = json['likes'];
    dislikes = json['dislikes'];
    userReaction = json['userReaction'];
    seen = json['seen'];
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
      'mediaFiles': mediaFiles,
      'likes': likes,
      'dislikes': dislikes,
      'userReaction': userReaction,
      'seen': seen,
      'shareLink': shareLink,
      'advertisement': advertisement,
      'contributionPosts': contributionPosts,
      'relatedPosts': relatedPosts
    };
  }

  static List<PostDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PostDto>()
        : json.map((value) => new PostDto.fromJson(value)).toList();
  }

  static Map<String, PostDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PostDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PostDto.fromJson(value));
    }
    return map;
  }
}
