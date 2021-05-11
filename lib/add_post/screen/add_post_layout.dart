import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/add_post/screen/add_post_card.dart';
import 'package:livefeed/common/blocs/post_form/post_form_bloc.dart';
import 'package:livefeed/common/widgets/network_error.dart';
import 'package:livefeed/theme.dart';

class AddPostLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostFormBloc, PostFormState>(
      builder: (context, state) {
        if (state is PostFormLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostFormLoadSuccess) {
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: LiveFeedTheme.screensBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: AddPostCard(),
              ),
            ),
          );
        } else if (state is PostFormLoadFailure) {
          return NetworkError(
            state.error,
            () => context.read<PostFormBloc>().add(PostFormLoaded()),
          );
        } else {
          return Center(
            child: Text('Invalid State'),
          );
        }
      },
    );
  }
}
