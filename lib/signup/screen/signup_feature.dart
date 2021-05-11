import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/signup/bloc/security_questions/security_questions_bloc.dart';
import 'package:livefeed/signup/bloc/signup/signup_bloc.dart';
import 'package:livefeed/signup/screen/security_questions_screen.dart';
import 'package:livefeed/signup/screen/signup_screen.dart';
import 'package:formz/formz.dart';
import 'package:livefeed/signup/screen/signup_verification_screen.dart';
import 'package:repository_core/repository_core.dart';

class SignupFeature extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignupFeature());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(create: (context) {
          return SignupBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
            userRepository: RepositoryProvider.of<UserRepositoryCore>(context),
          );
        }),
        BlocProvider<SecurityQuestionsBloc>(create: (context) {
          return SecurityQuestionsBloc();
        }),
      ],
      child: _SignupFeatureScreens(),
    );
  }
}

class _SignupFeatureScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiBlocListener(
    //   listeners: [
    //     BlocListener<SignupBloc, SignupState>(
    //       listenWhen: (previous, current) => previous.status != current.status,
    //       listener: (context, state) {
    //         if (state.status.isSubmissionSuccess) {
    //           Navigator.of(context).push(SecurityQuestionsScreen.route());
    //         }
    //       },
    //     ),
    //     BlocListener<SecurityQuestionsBloc, SecurityQuestionsState>(
    //       listenWhen: (previous, current) => previous.status != current.status,
    //       listener: (context, state) {
    //         if (state.status.isSubmissionSuccess) {
    //           Navigator.of(context).pop();
    //         }
    //       },
    //     ),
    //   ],
    //   child: SignupScreen(),
    // );
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      // return SignupScreen();
      if (state.signupFormStatus.isSubmissionSuccess) {
        return SignupVerificationScreen();
      } else {
        return SignupScreen();
      }
    });
  }
}
