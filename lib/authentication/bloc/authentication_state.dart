part of 'authentication_bloc.dart';

enum LandingScreen {
  login,
  signup,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unauthenticated,
    this.unauthenticatedScreen = LandingScreen.login,
    this.user,
    this.verificationEvent,
  });

  final AuthenticationStatus status;
  final UserEntity user;
  final VerificationEventEntity verificationEvent;
  final LandingScreen unauthenticatedScreen;

  const AuthenticationState.unknown(LandingScreen screen)
      : this._(unauthenticatedScreen: screen);

  const AuthenticationState.authenticated(UserEntity user, LandingScreen screen)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
          unauthenticatedScreen: screen,
        );

  const AuthenticationState.verifying(UserEntity user,
      VerificationEventEntity verificationEvent, LandingScreen screen)
      : this._(
          status: AuthenticationStatus.verifying,
          user: user,
          verificationEvent: verificationEvent,
          unauthenticatedScreen: screen,
        );

  const AuthenticationState.unauthenticated(LandingScreen screen)
      : this._(
          status: AuthenticationStatus.unauthenticated,
          unauthenticatedScreen: screen,
        );

  AuthenticationState.newScreen(
      AuthenticationState currentState, LandingScreen screen)
      : this._(
          unauthenticatedScreen: screen,
          status: currentState.status,
          user: currentState.user,
          verificationEvent: currentState.verificationEvent,
        );

  @override
  List<Object> get props =>
      [status, user, verificationEvent, unauthenticatedScreen];
}
