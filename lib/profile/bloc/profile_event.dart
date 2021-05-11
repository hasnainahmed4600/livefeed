part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileEvent {}

class AddressUpdated extends ProfileEvent {
  final String address;

  const AddressUpdated(this.address);

  @override
  List<Object> get props => [address];
}

class EmailUpdated extends ProfileEvent {
  final String email;
  const EmailUpdated(this.email);

  @override
  List<Object> get props => [email];
}

class PhoneNumberUpdated extends ProfileEvent {
  final String phoneNumber;
  const PhoneNumberUpdated(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class SaveAddressSubmitted extends ProfileEvent {}

class SaveCredentialsSubmitted extends ProfileEvent {}

class InterestUpdated extends ProfileEvent {
  final String interest;
  const InterestUpdated(this.interest);

  @override
  List<Object> get props => [interest];
}

class SaveInterestSubmitted extends ProfileEvent {}

class InterestRemoved extends ProfileEvent {
  final String interestId;
  const InterestRemoved(this.interestId);

  @override
  List<Object> get props => [interestId];
}

class LoggedOut extends ProfileEvent {
  const LoggedOut();
}
