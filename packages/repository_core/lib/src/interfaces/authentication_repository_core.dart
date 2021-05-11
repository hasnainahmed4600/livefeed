import 'package:repository_core/src/entities/entities.dart';

enum AuthenticationStatus { unknown, verifying, authenticated, unauthenticated }

abstract class AuthenticationRepositoryCore {
  Stream<AuthenticationStatus> get statusStream;
  Stream<String> get authKeyStream;
  Stream<UserEntity> get currentUserStream;
  Stream<VerificationEventEntity> get verificationEventStream;

  String get authKey;
  UserEntity get currentUser;
  VerificationEventEntity get verificationEvent;

  Future<void> phoneLogin(
      String phoneIsoCode, String phoneCountryCode, String phoneNumber);
  Future<void> emailLogin(String email, String password);
  Future<void> verify(
    String verificationCode, {
    String verificationEventId,
    String name,
    String phoneIsoCode,
    String phoneCountryCode,
    String phoneNumber,
  });
  Future<void> resendVerificationCode();
  void logOut();
}
