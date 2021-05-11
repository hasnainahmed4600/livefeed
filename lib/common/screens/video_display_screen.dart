import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livefeed/common/models/selected_media_file.dart';
import 'package:livefeed/common/widgets/video_player.dart';

class VideoDisplayScreen extends StatelessWidget {
  VideoDisplayScreen(this.displayFile);
  final SelectedMediaFile displayFile;

  static Route route(SelectedMediaFile displayFile) {
    return MaterialPageRoute<void>(
        builder: (_) => VideoDisplayScreen(displayFile));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: LiveFeedVideoControl.selectedVideo(
            displayFile,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
