import 'package:flutter/material.dart';
import 'package:livefeed/signup/screen/security_questions_form.dart';
import 'package:livefeed/signup/screen/signup_header.dart';

class SecurityQuestionsScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SecurityQuestionsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SecurityQuestionsLayout(),
    );
  }
}

class _SecurityQuestionsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          SignupHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: SecurityQuestionsForm(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '© 2017 - 2020 LIVE MEDIA INC. ALL RIGHTS RESERVED. PATENTS APPLIED FOR IN THE US AND ABROAD.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
