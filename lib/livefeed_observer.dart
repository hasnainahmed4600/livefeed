import 'package:bloc/bloc.dart';

class LivefeedObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(
        '${bloc.runtimeType} { currentState: ${change.currentState.toString()},\n nextState: ${change.nextState.toString()} }');
  }
}
