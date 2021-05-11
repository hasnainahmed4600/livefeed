import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/profile/bloc/profile_bloc.dart';
import 'package:livefeed/profile/screen/profile_layout.dart';
import 'package:repository_core/repository_core.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        );
      },
      child: ProfileLayout(),
    );
  }
}
