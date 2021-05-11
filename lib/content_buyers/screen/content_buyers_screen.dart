import 'package:flutter/material.dart';
import 'package:livefeed/content_buyers/screen/content_buyers_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/content_buyers/bloc/content_buyers_bloc.dart';

class ContentBuyersScreen extends StatelessWidget {
  // static Route route() {
  //   return MaterialPageRoute<void>(builder: (_) => ContentBuyersScreen());
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContentBuyersBloc>(
      create: (context) {
        return ContentBuyersBloc()..add(PostsListLoaded());
      },
      child: ContentBuyersLayout(),
    );
  }
}
