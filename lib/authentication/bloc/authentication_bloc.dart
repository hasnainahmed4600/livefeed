import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown(LandingScreen.login)) {
    _authenticationStatusSubscription = _authenticationRepository.statusStream
        .listen((status) => add(AuthenticationStatusChanged(status)));
    _verificationEventSubscription =
        authenticationRepository.verificationEventStream.listen(
      (event) {
        if (event != null) {
          add(AuthenticationStatusChanged(AuthenticationStatus.verifying));
        }
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;
  StreamSubscription<VerificationEventEntity> _verificationEventSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is LandingScreenUpdated) {
      yield AuthenticationState.newScreen(state, event.screen);
    }
  }

  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _verificationEventSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.verifying:
        var user = _authenticationRepository.currentUser;
        var verificationEvent = _authenticationRepository.verificationEvent;
        return user != null && verificationEvent != null
            ? AuthenticationState.verifying(
                user, verificationEvent, state.unauthenticatedScreen)
            : AuthenticationState.unauthenticated(state.unauthenticatedScreen);
      case AuthenticationStatus.authenticated:
        var user = _authenticationRepository.currentUser;
        return user != null
            ? AuthenticationState.authenticated(
                user, state.unauthenticatedScreen)
            : AuthenticationState.unauthenticated(state.unauthenticatedScreen);
      case AuthenticationStatus.unauthenticated:
        return AuthenticationState.unauthenticated(state.unauthenticatedScreen);
        break;
      default:
        return AuthenticationState.unknown(
          state.unauthenticatedScreen,
        );
    }
  }
}
