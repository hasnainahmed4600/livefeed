import 'package:flutter/material.dart';
import 'package:livefeed/signup/screen/signup_form.dart';
import 'package:livefeed/signup/screen/signup_header.dart';

class SignupScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SignupLayout(),
    );
  }
}

class _SignupLayout extends StatelessWidget {
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
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: SignupForm(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '© 2017 - 2021 LIVE MEDIA INC. ALL RIGHTS RESERVED. PATENTS APPLIED FOR IN THE US AND ABROAD.',
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
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child:
          // ),
        ],
      ),
    );
  }
}
