import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';

class SecurityQuestionsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: 15)),
        Text(
          'Signup',
          style: LiveFeedTheme.theme.textTheme.headline1,
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          'Please select 3 security questions. You will be asked to answer these questions in case you lose your phone number',
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            color: Color.fromRGBO(150, 150, 150, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.58,
          ),
        ),
      ],
    );
  }
}
