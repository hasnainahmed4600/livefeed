import 'package:flutter/material.dart';
import 'package:livefeed/signup/screen/signup_header.dart';
import 'package:livefeed/signup/screen/signup_verification_form.dart';

class SignupVerificationScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignupVerificationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          children: [
            SignupHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: SignupVerificationForm(),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 120)),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
