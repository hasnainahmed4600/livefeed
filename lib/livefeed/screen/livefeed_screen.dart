import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/livefeed/bloc/livefeed_bloc.dart';
import 'package:livefeed/livefeed/screen/livefeed_layout.dart';

class LivefeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LivefeedBloc()..add(LivefeedLoaded());
      },
      child: LivefeedLayout(),
    );
  }
}
