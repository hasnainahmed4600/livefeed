part of 'content_creators_bloc.dart';

abstract class ContentCreatorsEvent extends Equatable {
  const ContentCreatorsEvent();

  @override
  List<Object> get props => [];
}

class HeadlineUpdated extends ContentCreatorsEvent {
  const HeadlineUpdated(this.headline);
  final String headline;

  @override
  List<Object> get props => [headline];
}

class DescriptionUpdated extends ContentCreatorsEvent {
  const DescriptionUpdated(this.description);
  final String description;

  @override
  List<Object> get props => [description];
}

class CategoryUpdated extends ContentCreatorsEvent {
  const CategoryUpdated(this.category);
  final String category;

  @override
  List<Object> get props => [category];
}

class PhotoAdded extends ContentCreatorsEvent {
  const PhotoAdded(this.photoPath);
  final String photoPath;

  @override
  List<Object> get props => [photoPath];
}

class VideoAdded extends ContentCreatorsEvent {
  const VideoAdded(this.videoPath);
  final String videoPath;

  @override
  List<Object> get props => [videoPath];
}

class LocationUpdated extends ContentCreatorsEvent {
  const LocationUpdated(this.location);
  final String location;

  @override
  List<Object> get props => [location];
}