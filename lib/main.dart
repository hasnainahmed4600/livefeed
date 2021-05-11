import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:livefeed/app.dart';
import 'package:livefeed/livefeed_observer.dart';
import 'package:repository_core/repository_core.dart';

void main() {
  Bloc.observer = LivefeedObserver();
  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ),
  );
}
