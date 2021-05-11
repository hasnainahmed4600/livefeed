import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/add_post/bloc/add_post_bloc.dart';
import 'package:livefeed/add_post/screen/add_post_layout.dart';
import 'package:livefeed/common/blocs/post_form/post_form_bloc.dart';

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PostFormBloc()..add(PostFormLoaded());
      },
      child: AddPostLayout(),
    );
  }
}
