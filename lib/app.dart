import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:livefeed/authentication/bloc/authentication_bloc.dart';
import 'package:livefeed/home/bloc/apptab/apptab_bloc.dart';
import 'package:livefeed/home/screens/home_screen.dart';
import 'package:livefeed/login/screen/login_screen.dart';
import 'package:livefeed/login/screen/verification_screen.dart';
import 'package:livefeed/signup/screen/signup_feature.dart';
import 'package:livefeed/theme.dart';
import 'package:repository_core/repository_core.dart';
import 'package:livefeed/marketplace/bloc/marketplace_tab_bloc.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  });

  final AuthenticationRepository authenticationRepository;
  final UserRepositoryCore userRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authenticationRepository),
          RepositoryProvider.value(value: userRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) => AuthenticationBloc(
                authenticationRepository: authenticationRepository,
              ),
            ),
            BlocProvider<ApptabBloc>(
              create: (BuildContext context) => ApptabBloc(),
            ),
            BlocProvider<MarketplaceTabBloc>(
              create: (BuildContext context) => MarketplaceTabBloc(),
            ),
            // BlocProvider<LandingScreenBloc>(
            //   create: (BuildContext context) => LandingScreenBloc(),
            // ),
          ],
          child: AppScreen(),
        ));
  }
}

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> removeSecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId('sandbox-sq0idb-l3Zuu2bh5-JOuC8kva7DOw');
  }

  @override
  void initState() {
    secureScreen();
    _initSquarePayment();
    super.initState();
  }

  @override
  void dispose() {
    removeSecureScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: LiveFeedTheme.theme,
      // debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) =>
              previous.status != current.status ||
              previous.unauthenticatedScreen != current.unauthenticatedScreen,
          listener: (context, authenticationState) {
            switch (authenticationState.status) {
              case AuthenticationStatus.verifying:
                _navigator.pushAndRemoveUntil(
                  VerificationScreen.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                if (authenticationState.unauthenticatedScreen ==
                    LandingScreen.login) {
                  _navigator.pushAndRemoveUntil(
                    LoginScreen.route(),
                    (route) => false,
                  );
                } else {
                  _navigator.pushAndRemoveUntil(
                    SignupFeature.route(),
                    (route) => false,
                  );
                }
                break;
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil(
                  HomeScreen.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                if (authenticationState.unauthenticatedScreen ==
                    LandingScreen.login) {
                  _navigator.pushAndRemoveUntil(
                    LoginScreen.route(),
                    (route) => false,
                  );
                } else {
                  _navigator.pushAndRemoveUntil(
                    SignupFeature.route(),
                    (route) => false,
                  );
                }
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => LoginScreen.route(),
    );
  }
}
