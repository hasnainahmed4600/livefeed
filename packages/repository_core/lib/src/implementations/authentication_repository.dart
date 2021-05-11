// TODO: Put public facing types in this file.

import 'dart:async';

import 'package:repository_core/src/interfaces/interfaces.dart';
import 'package:repository_core/src/entities/entities.dart';
import 'package:uuid/uuid.dart';

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}

class AuthenticationRepository implements AuthenticationRepositoryCore {
  final _statusController = StreamController<AuthenticationStatus>();
  final _authKeyController = StreamController<String>();
  final _currentUserController = StreamController<UserEntity>();
  final _verificationEventController =
      StreamController<VerificationEventEntity>();
  String _authKey;
  UserEntity _currentUser;
  VerificationEventEntity _verificationEvent;

  @override
  Stream<AuthenticationStatus> get statusStream async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _statusController.stream;
  }

  @override
  Stream<String> get authKeyStream async* {
    yield null;
    yield* _authKeyController.stream;
  }

  @override
  String get authKey => _authKey;

  @override
  UserEntity get currentUser => _currentUser;

  @override
  VerificationEventEntity get verificationEvent => _verificationEvent;

  @override
  Stream<UserEntity> get currentUserStream async* {
    yield null;
    yield* _currentUserController.stream;
  }

  @override
  Stream<VerificationEventEntity> get verificationEventStream async* {
    yield* _verificationEventController.stream;
  }

  @override
  Future<void> emailLogin(String email, String password) {
    // TODO: implement emailLogin
    throw UnimplementedError();
  }

  @override
  Future<void> phoneLogin(
      String phoneIsoCode, String phoneCountryCode, String phoneNumber) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        _statusController.add(AuthenticationStatus.verifying);

        var user = UserEntity(
          id: Uuid().v4(),
          phoneIsoCode: phoneIsoCode,
          phoneCountryCode: phoneCountryCode,
          phoneNumber: phoneNumber,
        );
        _currentUserController.add(user);
        _currentUser = user;

        var verificationEvent = VerificationEventEntity(
          id: Uuid().v4(),
          requestedOn: DateTime.now(),
          throttleDurationSeconds: 10,
        );
        _verificationEventController.add(verificationEvent);
        _verificationEvent = verificationEvent;
      },
    );
  }

  @override
  Future<void> verify(
    String verificationCode, {
    String verificationEventId,
    String name,
    String phoneIsoCode,
    String phoneCountryCode,
    String phoneNumber,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        // Adding user entity here to account for signup workflow.
        // This is temporary and will be replaced by user dto payload from api when integration is done.
        var user = UserEntity(
          id: Uuid().v4(),
          phoneIsoCode: phoneIsoCode,
          phoneCountryCode: phoneCountryCode,
          phoneNumber: phoneNumber,
        );
        _currentUserController.add(user);
        _currentUser = user;
        //

        var authKey = Uuid().v4();
        _authKeyController.add(authKey);
        _authKey = authKey;

        _statusController.add(AuthenticationStatus.authenticated);

        _verificationEventController.add(null);
        _verificationEvent = null;
      },
    );
  }

  @override
  Future<void> resendVerificationCode() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        var verificationEvent = VerificationEventEntity(
          id: Uuid().v4(),
          requestedOn: DateTime.now(),
          throttleDurationSeconds: 30,
        );
        _verificationEventController.add(verificationEvent);
        _verificationEvent = verificationEvent;
      },
    );
  }

  @override
  void logOut() {
    _statusController.add(AuthenticationStatus.unauthenticated);

    _currentUserController.add(null);
    _currentUser = null;

    _verificationEventController.add(null);
    _verificationEvent = null;

    _authKeyController.add(null);
    _authKey = null;
  }

  void dispose() {
    _statusController.close();
    _authKeyController.close();
    _currentUserController.close();
    _verificationEventController.close();
  }
}
