import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class SelectedMediaFile extends Equatable {
  SelectedMediaFile({
    String id,
    this.file,
    this.isVideo = false,
    this.videoThumbnail,
  }) : _id = id ?? Uuid().v4();

  String get id => _id;

  final String _id;
  final File file;
  final bool isVideo;
  final Uint8List videoThumbnail;

  @override
  String toString() =>
      'SelectedMediaFile {id: $id, file: ${file.path}, isVideo: $isVideo, videoThumbnail: ${videoThumbnail.toString()}';

  @override
  List<Object> get props => [_id, file, isVideo, videoThumbnail, id];
}
