import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class PressItemVm extends Equatable {
  PressItemVm({
    String id,
    this.postDate,
    this.title,
    this.content,
    this.imagePath,
    this.networkImage = false,
    this.hasVideo = false,
    this.videoUrl,
  })  : _id = id ?? Uuid().v4(),
        assert(postDate != null),
        assert(title != null),
        assert(content != null),
        assert(imagePath != null);

  final String _id;
  final DateTime postDate;
  final String title;
  final String content;
  final String imagePath;
  final bool networkImage;
  final bool hasVideo;
  final String videoUrl;

  String get id => _id;

  @override
  List<Object> get props => [
        _id,
        postDate,
        title,
        content,
        imagePath,
        networkImage,
        hasVideo,
        videoUrl,
      ];
}
