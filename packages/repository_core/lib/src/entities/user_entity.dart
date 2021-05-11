import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String photoUrl;
  final String email;
  final String phoneIsoCode;
  final String phoneCountryCode;
  final String phoneNumber;
  final String address;
  final String zipCode;

  UserEntity({
    this.id,
    this.name,
    this.photoUrl,
    this.email,
    this.phoneIsoCode,
    this.phoneCountryCode,
    this.phoneNumber,
    this.address,
    this.zipCode,
  });

  UserEntity copyWith({
    String id,
    String name,
    String photoUrl,
    String email,
    String phoneIsoCode,
    String phoneCountryCode,
    String phoneNumber,
    String address,
    String zipCode,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      phoneIsoCode: phoneIsoCode ?? this.phoneIsoCode,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        photoUrl,
        email,
        phoneNumber,
        address,
        zipCode,
      ];

  @override
  String toString() {
    return 'UserEntity{id: $id, name: $name, photoUrl: $photoUrl, email: $email, phoneNumber: $phoneNumber, address: $address, zipCode: $zipCode}';
  }
}
