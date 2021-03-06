part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoadInProgress extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final UserProfileDto user;
  ProfileLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileLoadFailure extends ProfileState {
  final String error;
  ProfileLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
