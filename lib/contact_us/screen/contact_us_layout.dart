import 'package:flutter/material.dart';
import 'package:livefeed/contact_us/screen/contact_us_form_card.dart';
import 'package:livefeed/contact_us/screen/contact_us_header.dart';
import 'package:livefeed/theme.dart';

class ContactUsLayout extends StatelessWidget {
  ContactUsLayout({this.initialBodyText});

  final String initialBodyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiveFeedTheme.screensBackgroundColor,
      child: Column(
        children: [
          ContactUsHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: Column(
                    children: [
                      // Text(
                      //   'LiveFEED is created for the people by the people. We\'d love to hear from you how we can make LiveFEED even better!',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.black,
                      //     height: 1.5,
                      //   ),
                      // ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ContactUsFormCard(
                        initialBodyText:
                            initialBodyText != null ? initialBodyText : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
