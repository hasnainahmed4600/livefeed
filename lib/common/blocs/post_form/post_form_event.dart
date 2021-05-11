part of 'post_form_bloc.dart';

abstract class PostFormEvent extends Equatable {
  const PostFormEvent();

  @override
  List<Object> get props => [];
}

class PostFormLoaded extends PostFormEvent {
  const PostFormLoaded();
}

class HeadlineUpdated extends PostFormEvent {
  const HeadlineUpdated(this.headline);
  final String headline;

  @override
  List<Object> get props => [headline];
}

class DescriptionUpdated extends PostFormEvent {
  const DescriptionUpdated(this.description);
  final String description;

  @override
  List<Object> get props => [description];
}

class CategoryUpdated extends PostFormEvent {
  const CategoryUpdated(this.category);
  final String category;

  @override
  List<Object> get props => [category];
}

class MediaFileAdded extends PostFormEvent {
  const MediaFileAdded(this.file);
  final SelectedMediaFile file;

  @override
  List<Object> get props => [file];
}

class MediaFileRemoved extends PostFormEvent {
  const MediaFileRemoved(this.fileId);
  final String fileId;

  @override
  List<Object> get props => [fileId];
}

class LocationUpdated extends PostFormEvent {
  const LocationUpdated(this.location);
  final String location;

  @override
  List<Object> get props => [location];
}