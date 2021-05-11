import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/login/bloc/login_bloc.dart';
import 'package:livefeed/login/screen/login_form.dart';
import 'package:repository_core/repository_core.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        ),
        child: LoginForm(),
      ),
    );
  }
}
