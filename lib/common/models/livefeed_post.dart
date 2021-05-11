import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class LiveFeedPost extends Equatable {
  final String _id;
  final String userName;
  final DateTime postDate;
  final String postHeadline;
  final String postLocation;
  final String assetPath;
  final bool isNetworkAsset;
  final bool isVideoAsset;
  final bool _seen;
  final String videoAssetThumbnailUrl;

  String get id => _id;
  bool get seen => _seen;

  LiveFeedPost({
    String id,
    this.userName,
    this.postDate,
    this.postHeadline,
    this.postLocation,
    this.assetPath,
    this.isNetworkAsset = false,
    this.isVideoAsset,
    bool seen,
    this.videoAssetThumbnailUrl,
  })  : _id = id ?? Uuid().v4(),
        _seen = seen ?? Random().nextBool();

  LiveFeedPost copyWith({
    String id,
    String userName,
    DateTime postDate,
    String postHeadline,
    String postLocation,
    String assetPath,
    bool isNetworkAsset,
    bool isVideoAsset,
    bool seen,
    String videoAssetThumbnailUrl,
  }) {
    return LiveFeedPost(
      id: id ?? this._id,
      userName: userName ?? this.userName,
      postDate: postDate ?? this.postDate,
      postHeadline: postHeadline ?? this.postHeadline,
      postLocation: postLocation ?? this.postLocation,
      assetPath: assetPath ?? this.assetPath,
      isNetworkAsset: isNetworkAsset ?? this.isNetworkAsset,
      isVideoAsset: isVideoAsset ?? this.isVideoAsset,
      seen: seen ?? this._seen,
      videoAssetThumbnailUrl:
          videoAssetThumbnailUrl ?? this.videoAssetThumbnailUrl,
    );
  }

  String getInitials() {
    List<String> names = userName.split(' ');
    String initials = '';
    int numWords = 2;

    if(numWords < names.length) {
      numWords = names.length;
    }
    for(var i = 0; i < numWords; i++){
      initials += '${names[i][0]}';
    }
    return initials;
  }


  @override
  List<Object> get props => [
        id,
        _id,
        userName,
        postDate,
        postHeadline,
        postLocation,
        assetPath,
        isNetworkAsset,
        isVideoAsset,
        _seen,
        seen,
        videoAssetThumbnailUrl,
      ];
}
