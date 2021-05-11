import 'package:flutter/material.dart';
import 'package:livefeed/common/models/selected_media_file.dart';

class ImageDisplayScreen extends StatelessWidget {
  ImageDisplayScreen(this.displayFile);
  final SelectedMediaFile displayFile;

  static Route route(SelectedMediaFile displayFile) {
    return MaterialPageRoute<void>(
        builder: (_) => ImageDisplayScreen(displayFile));
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
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: FileImage(displayFile.file),
          ),
        ),
      ),
    );
  }
}
