import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';

class TimelineSearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LiveFeedTheme.theme.copyWith(
        primaryColor: Colors.grey,
        inputDecorationTheme: LiveFeedTheme.theme.inputDecorationTheme.copyWith(
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            height: 1.55,
            fontSize: 14,
          ),
        ),
      ),
      child: TextField(
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 20,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 20, right: 14),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          hintText: 'Search for topic or location..',
          hintStyle: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontSize: 15,
            color: Colors.grey,
          ),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
