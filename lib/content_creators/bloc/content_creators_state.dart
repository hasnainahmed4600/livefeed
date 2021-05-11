part of 'content_creators_bloc.dart';

class ContentCreatorsState extends Equatable {
  const ContentCreatorsState({
    this.headline = '',
    this.description = '',
    this.category = '',
    this.uploadedImagePaths = const [],
    this.uploadedVideoPaths = const [],
    this.location = '',
  });

  final String headline;
  final String description;
  final String category;
  final List<String> uploadedVideoPaths;
  final List<String> uploadedImagePaths;
  final String location;

  ContentCreatorsState copyWith({
    String headline,
    String description,
    String category,
    List<String> uploadedVideoPaths,
    List<String> uploadedImagePaths,
    String location,
  }) {
    return ContentCreatorsState(
      headline: headline ?? this.headline,
      description: description ?? this.description,
      category: category ?? this.category,
      uploadedVideoPaths: uploadedVideoPaths ?? this.uploadedVideoPaths,
      uploadedImagePaths: uploadedImagePaths ?? this.uploadedImagePaths,
      location: location ?? this.location,
    );
  }

  @override
  List<Object> get props => [
        headline,
        description,
        category,
        uploadedVideoPaths,
        uploadedImagePaths,
        location,
      ];
}
