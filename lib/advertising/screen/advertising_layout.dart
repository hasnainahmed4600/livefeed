import 'package:flutter/material.dart';
import 'package:livefeed/advertising/screen/advertising_header.dart';
import 'package:livefeed/advertising/screen/current_ads.dart';
import 'package:livefeed/advertising/screen/new_ad_form.dart';
import 'package:livefeed/theme.dart';

class AdvertisingLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiveFeedTheme.screensBackgroundColor,
      width: double.infinity,
      child: Column(
        children: [
          AdvertisingHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    CurrentAds(),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NewAdForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
