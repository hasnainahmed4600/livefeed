import 'package:flutter/material.dart';
import 'package:livefeed/livefeed/bloc/livefeed_bloc.dart';
import 'package:livefeed/livefeed/screen/animated_livefeed.dart';
import 'package:livefeed/livefeed/screen/livefeed_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/livefeed/screen/livefeed_list.dart';

class LivefeedLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LivefeedLayoutState();
}

class _LivefeedLayoutState extends State<LivefeedLayout> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    // print(_scrollController.position.extentBefore);
    if (_scrollController.position.extentBefore > 120) {
      context.read<LivefeedBloc>().add(ScrolledPastTopRollInThreshold());
    } else {
      context.read<LivefeedBloc>().add(ScrolledIntoTopRollInThreshold());
    }
    if (_scrollController.position.extentAfter < 200) {
      context.read<LivefeedBloc>().add(EndOfLivefeedListReached());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Column(
        children: [
          LivefeedHeader(
            onScrollToTopTapped: () {
              _scrollController.animateTo(
                0.0,
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
            height: 1,
          ),
          Expanded(
            child: LivefeedList(_scrollController),
            // child: SingleChildScrollView(
            //   // controller: _scrollController,
            //   child: AnimatedLivefeedList(_scrollController),
            // ),
          ),
        ],
      ),
    );
  }
}
