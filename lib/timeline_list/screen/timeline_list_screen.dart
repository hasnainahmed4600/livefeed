import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/timeline_list/bloc/timeline_list_bloc.dart';
import 'package:livefeed/timeline_list/screen/timeline_list_layout.dart';

class TimelineListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TimelineListBloc()..add(TimelineListLoaded());
      },
      child: TimelineListLayout(),
    );
  }
}
