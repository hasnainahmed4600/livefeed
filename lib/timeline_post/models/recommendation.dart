import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Recommendation extends Equatable {
  final String category;
  final String message;
  final DateTime postDate;
  final String imagePath;
  final bool networkImage;
  const Recommendation({
    this.category,
    this.message,
    this.postDate,
    this.imagePath,
    this.networkImage = false,
  });
  @override
  List<Object> get props => [
        category,
        message,
        postDate,
        imagePath,
        networkImage,
      ];
}
