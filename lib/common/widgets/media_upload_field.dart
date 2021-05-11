import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livefeed/common/models/selected_media_file.dart';
import 'package:livefeed/common/screens/video_display_screen.dart';
import 'package:livefeed/theme.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:livefeed/common/screens/image_display_screen.dart';

class MediaUploadField extends StatefulWidget {
  MediaUploadField({
    this.videoLimit = 1,
    this.photoLimit = 5,
    this.showLimitIndicators = true,
    this.onFilePicked,
    this.onFileDeleted,
  });

  final int videoLimit;
  final int photoLimit;
  final bool showLimitIndicators;
  final Function(SelectedMediaFile file) onFilePicked;
  final Function(String fileId) onFileDeleted;

  @override
  State<StatefulWidget> createState() => _MediaUploadFieldState(
        onFilePicked: onFilePicked,
        onFileDeleted: onFileDeleted,
        videoLimit: videoLimit,
        photoLimit: photoLimit,
        showLimitIndicators: showLimitIndicators,
      );
}

class _MediaUploadFieldState extends State<MediaUploadField> {
  _MediaUploadFieldState({
    this.videoLimit,
    this.photoLimit,
    this.showLimitIndicators,
    this.onFilePicked,
    this.onFileDeleted,
  });

  List<SelectedMediaFile> _files = [];

  final picker = ImagePicker();

  final int videoLimit;
  final int photoLimit;
  final bool showLimitIndicators;
  final Function(SelectedMediaFile file) onFilePicked;
  final Function(String fileId) onFileDeleted;

  Future<Uint8List> getVideoThumbnail(File videoFile) async {
    return await VideoThumbnail.thumbnailData(
      video: videoFile.path,
      imageFormat: ImageFormat.JPEG,
      // quality: 25,
      // maxWidth: 128,
    );
  }

  Future imageFromGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      // imageQuality: 25,
    );

    setState(() {
      if (pickedFile != null) {
        try {
          final newFile = SelectedMediaFile(
            file: File(pickedFile.path),
            isVideo: false,
          );
          _files.add(newFile);
          if (onFilePicked != null) onFilePicked(newFile);
          return;
        } catch (e) {}
      } else {
        print('No image selected');
      }
    });
  }

  Future videoFromGallery(BuildContext context) async {
    final pickedFile = await picker.getVideo(
      source: ImageSource.gallery,
    );
    final thumbnail = await getVideoThumbnail(File(pickedFile.path));

    setState(() {
      if (pickedFile != null) {
        try {
          final newFile = SelectedMediaFile(
            file: File(pickedFile.path),
            isVideo: true,
            videoThumbnail: thumbnail,
          );
          _files.add(newFile);
          if (onFilePicked != null) onFilePicked(newFile);
          return;
        } catch (e) {}
      } else {
        print('No video selected');
      }
    });
  }

  Future imageFromCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      // imageQuality: 25,
    );

    setState(() {
      if (picker != null) {
        print(pickedFile.path);
        try {
          final newFile = SelectedMediaFile(
            file: File(pickedFile.path),
            isVideo: false,
          );
          _files.add(newFile);
          if (onFilePicked != null) onFilePicked(newFile);
          return;
        } catch (e) {}
      } else {
        print('No image selected');
      }
    });
  }

  Future videoFromCamera(BuildContext context) async {
    final pickedFile = await picker.getVideo(
      source: ImageSource.camera,
    );
    final thumbnail = await getVideoThumbnail(File(pickedFile.path));

    setState(() {
      if (picker != null) {
        print(pickedFile.path);
        try {
          final newFile = SelectedMediaFile(
            file: File(pickedFile.path),
            isVideo: true,
            videoThumbnail: thumbnail,
          );
          _files.add(newFile);
          if (onFilePicked != null) onFilePicked(newFile);
          return;
        } catch (e) {}
      } else {
        print('No video selected');
      }
    });
  }

  void _showPicker(context) {
    final photosCount = _files.where((file) => !file.isVideo).length;
    final videosCount = _files.where((file) => file.isVideo).length;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                if (photosCount < photoLimit)
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        imageFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                if (videosCount < videoLimit)
                  new ListTile(
                      leading: new Icon(Icons.video_library),
                      title: new Text('Video Library'),
                      onTap: () {
                        videoFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                if (photosCount < photoLimit)
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Take Photo'),
                    onTap: () {
                      imageFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                if (videosCount < videoLimit)
                  new ListTile(
                    leading: new Icon(Icons.videocam),
                    title: new Text('Record Video'),
                    onTap: () {
                      videoFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLimitIndicators() {
    final photosCount = _files.where((file) => !file.isVideo).length;
    final videosCount = _files.where((file) => file.isVideo).length;
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.grey,
        ),
        children: [
          WidgetSpan(
            child: Icon(
              Icons.photo_camera,
              color: Colors.grey,
            ),
            alignment: PlaceholderAlignment.middle,
          ),
          TextSpan(text: '$photosCount/$photoLimit '),
          WidgetSpan(
            child: Icon(
              Icons.videocam,
              color: Colors.grey,
            ),
            alignment: PlaceholderAlignment.middle,
          ),
          TextSpan(text: '$videosCount/$videoLimit'),
        ],
      ),
    );
  }

  Widget _buildSelectedFileControls() {
    var tiles = <Widget>[];
    _files.forEach((file) {
      tiles.add(_PickedFileTile(
        file,
        onDeleteTapped: (fileId) {
          setState(() {
            _files = [
              ..._files.where((element) => element.id != fileId).toList()
            ];
          });
          onFileDeleted(fileId);
        },
      ));
    });

    final photosCount = _files.where((file) => !file.isVideo).length;
    final videosCount = _files.where((file) => file.isVideo).length;

    Widget selectedFileItems = ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 125,
        maxWidth: double.infinity,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...tiles,
          if (photosCount < photoLimit || videosCount < videoLimit)
            GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: _AddMorePanel(),
            )
          else
            _NoMoreFilesAllowedPanel(),
        ],
      ),
    );

    if (showLimitIndicators) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          selectedFileItems,
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: _buildLimitIndicators(),
          ),
        ],
      );
    } else
      return selectedFileItems;
  }

  @override
  Widget build(BuildContext context) {
    if (_files.length > 0) {
      return _buildSelectedFileControls();
    } else {
      return GestureDetector(
        onTap: () {
          _showPicker(context);
        },
        child: _NoMediaPanel(),
      );
    }
  }
}

class _NoMediaPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey[400],
      strokeWidth: 2,
      dashPattern: [12],
      borderType: BorderType.RRect,
      child: Container(
        width: double.infinity,
        color: Colors.grey[200],
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 25)),
            Container(
              width: 38,
              height: 38,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image(
                  image: AssetImage('assets/images/upload_image.png'),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            RichText(
              text: TextSpan(
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Click here',
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      color: LiveFeedTheme.theme.highlightColor,
                    ),
                  ),
                  TextSpan(text: ' to upload photo/video'),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 25)),
          ],
        ),
      ),
    );
  }
}

class _AddMorePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey[400],
      strokeWidth: 2,
      dashPattern: [12],
      borderType: BorderType.RRect,
      child: Container(
        width: 125,
        height: 125,
        color: Colors.grey[200],
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 25)),
            Container(
              width: 38,
              height: 38,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image(
                  image: AssetImage('assets/images/upload_image.png'),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            RichText(
              text: TextSpan(
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Upload',
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      color: LiveFeedTheme.theme.highlightColor,
                    ),
                  ),
                  TextSpan(text: ' more'),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 25)),
          ],
        ),
      ),
    );
  }
}

class _NoMoreFilesAllowedPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey[400],
      strokeWidth: 2,
      dashPattern: [12],
      borderType: BorderType.RRect,
      child: Container(
        width: 125,
        height: 125,
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning),
            Text(
              'No more files allowed',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PickedFileTile extends StatelessWidget {
  _PickedFileTile(
    this.file, {
    this.onDeleteTapped,
  });

  final SelectedMediaFile file;
  final Function(String fileId) onDeleteTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: file.isVideo
              ? MemoryImage(file.videoThumbnail)
              : FileImage(file.file),
        ),
      ),
      child: Column(
        verticalDirection: VerticalDirection.up,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap:
                onDeleteTapped != null ? () => onDeleteTapped(file.id) : null,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          if (file.isVideo)
            Expanded(
              child: GestureDetector(
                onTap: file.isVideo
                    ? () => Navigator.of(context)
                        .push(VideoDisplayScreen.route(file))
                    : () => Navigator.of(context)
                        .push(ImageDisplayScreen.route(file)),
                behavior: HitTestBehavior.opaque,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            )
          else
            Expanded(
              child: GestureDetector(
                onTap: file.isVideo
                    ? () => Navigator.of(context)
                        .push(VideoDisplayScreen.route(file))
                    : () => Navigator.of(context)
                        .push(ImageDisplayScreen.route(file)),
                behavior: HitTestBehavior.opaque,
              ),
            ),
        ],
      ),
    );
  }
}
