import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/feedback/bloc/feedback_form_bloc.dart';
import 'package:livefeed/theme.dart';

class FeedbackHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackFormBloc, FeedbackFormState>(
      buildWhen: (previous, current) =>
          previous.formFocused != current.formFocused,
      builder: (context, state) {
        return Container(
          height: state.formFocused ? 100 : 180,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/earth3x.png'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FEEDBACK',
                      style: LiveFeedTheme.theme.textTheme.headline1.copyWith(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Your voice matters',
                      style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
