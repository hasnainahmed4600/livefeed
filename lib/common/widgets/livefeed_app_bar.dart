import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';

class LivefeedAppBar {
  LivefeedAppBar({
    this.context,
    this.onLogoTapped,
    this.onHowItWorksTapped,
    this.onMarketplaceTapped,
    this.howItWorksActive = false,
    this.marketplaceActive = false,
  });

  final BuildContext context;
  final Function onLogoTapped;
  final Function onHowItWorksTapped;
  final Function onMarketplaceTapped;
  final bool howItWorksActive;
  final bool marketplaceActive;

  AppBar build() {
    final Text howItWorksLabel = Text(
      'HOW IT WORKS',
      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.bold,
        color:
            howItWorksActive ? LiveFeedTheme.theme.accentColor : Colors.black,
        fontSize: 13,
      ),
    );
    return AppBar(
      leadingWidth: 210,
      leading: Padding(
        padding: EdgeInsets.only(
          left: 10,
        ),
        child: GestureDetector(
          onTap: onLogoTapped == null ? null : onLogoTapped,
          child: Container(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image(
                image: AssetImage('assets/images/livefeed_logo3x.png'),
              ),
            ),
          ),
        ),
      ),
      toolbarHeight: 55,
      elevation: 0.0,
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: howItWorksActive
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            if (howItWorksActive)
              Container(
                width: 110,
                height: 8,
                color: LiveFeedTheme.theme.accentColor,
              ),
            if (howItWorksActive)
              const Padding(padding: EdgeInsets.only(top: 11)),
            if (onHowItWorksTapped != null && !howItWorksActive)
              GestureDetector(
                onTap: onHowItWorksTapped,
                child: howItWorksLabel,
              )
            else
              howItWorksLabel,
          ],
        ),
        const Padding(padding: EdgeInsets.all(5.0)),
        Padding(
          padding: EdgeInsets.only(right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: marketplaceActive
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              if (marketplaceActive)
                Container(
                  width: 100,
                  height: 8,
                  color: LiveFeedTheme.theme.accentColor,
                ),
              if (marketplaceActive)
                const Padding(padding: EdgeInsets.only(top: 10)),
              GestureDetector(
                onTap: onMarketplaceTapped == null || marketplaceActive
                    ? null
                    : onMarketplaceTapped,
                child: Text(
                  'MARKETPLACE',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: marketplaceActive
                        ? LiveFeedTheme.theme.accentColor
                        : Colors.black,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
