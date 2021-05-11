import 'package:bloc_test/bloc_test.dart';
import 'package:livefeed/login/bloc/login_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:repository_core/repository_core.dart';

// class MockLoginBloc extends MockBloc<LoginBloc> implements LoginBloc {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}
