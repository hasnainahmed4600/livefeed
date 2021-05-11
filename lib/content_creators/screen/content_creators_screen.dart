import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/common/blocs/post_form/post_form_bloc.dart';
import 'package:livefeed/contact_us/models/contact_us_type_field.dart';
import 'package:livefeed/contact_us/screen/contact_us_screen.dart';
import 'package:livefeed/content_creators/bloc/content_creators_bloc.dart';
import 'package:livefeed/content_creators/screen/content_creators_layout.dart';
import 'package:livefeed/theme.dart';

class ContentCreatorsScreen extends StatelessWidget {
  RichText _buildLockedCallToAction(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
              text:
                  'Currently open for select members only.\n\n'),
          TextSpan(
            text:
                'Click here to sign up for updates and\nget an opportunity to try it!',
            recognizer: new TapGestureRecognizer()
              ..onTap = () => Navigator.of(context).push(ContactUsScreen.route(
                    formType: ContactUsType.marketplace,
                    initialBody: 'I\'d like to check it out!',
                  )),
            style: TextStyle(
              color: LiveFeedTheme.theme.highlightColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 1.0, color: Colors.grey[400]),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: _buildLockedCallToAction(context),
          ),
        ),
      ),
    );
    // return BlocProvider<PostFormBloc>(
    //   create: (context) {
    //     return PostFormBloc()..add(PostFormLoaded());
    //   },
    //   child: ContentCreatorsLayout(),
    // );
  }
}
