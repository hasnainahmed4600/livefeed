import 'package:equatable/equatable.dart';

class PostComment extends Equatable {
  final String userName;
  final DateTime postDate;
  final String postLocation;
  final String message;
  final String imagePath;
  final bool networkImage;

  const PostComment({
    this.userName,
    this.postDate,
    this.postLocation,
    this.message,
    this.imagePath,
    this.networkImage = false,
  });

  PostComment copyWith({
    String userName,
    DateTime postDate,
    String postLocation,
    String message,
    String imagePath,
    bool networkImage,
  }) {
    return PostComment(
      userName: userName ?? this.userName,
      postDate: postDate ?? this.postDate,
      postLocation: postLocation ?? this.postLocation,
      message: message ?? this.message,
      imagePath: imagePath ?? this.imagePath,
      networkImage: networkImage ?? this.networkImage,
    );
  }

  @override
  List<Object> get props => [
        userName,
        postDate,
        postLocation,
        message,
        imagePath,
        networkImage,
      ];
}
