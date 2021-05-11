import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/contact_us/bloc/contact_us_form_bloc.dart';
import 'package:livefeed/theme.dart';

class ContactUsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
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
                child: Text(
                  'CONTACT US',
                  style: LiveFeedTheme.theme.textTheme.headline1.copyWith(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
