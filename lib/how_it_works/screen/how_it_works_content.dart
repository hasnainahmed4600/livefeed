import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/how_it_works/bloc/how_it_works_bloc.dart';

class HowItWorksContent extends StatelessWidget {
  List<Widget> _translateQuestionsToWidgets(
      List<HowItWorksQuestion> questions) {
    var toReturnWidgets = <Widget>[];
    questions.forEach(
      (question) {
        switch (question) {
          case HowItWorksQuestion.what_livefeed:
            toReturnWidgets.add(Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _WhatIsLivefeedCard(),
            ));
            break;
          case HowItWorksQuestion.how_signup:
            // toReturnWidgets.add(Padding(
            //   padding: EdgeInsets.symmetric(vertical: 5),
            //   child: _HowToSignUpCard(),
            // ));
            break;
          case HowItWorksQuestion.marketplace_howto:
            toReturnWidgets.add(Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _MarketplaceHowToCard(),
            ));
            break;
          case HowItWorksQuestion.why_otp:
            toReturnWidgets.add(Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _OtpInfoCard(),
            ));
            break;
          case HowItWorksQuestion.update_phone_how:
            toReturnWidgets.add(Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _UpdatePhoneNumberCard(),
            ));
            break;
          case HowItWorksQuestion.what_if_lose_access:
            toReturnWidgets.add(Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _ContactUsCard(),
            ));
            break;
        }
      },
    );

    return toReturnWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HowItWorksBloc, HowItWorksState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),
            state.isSearching
                ? Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'THE QUESTION YOU SEARCHED',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'FREQUENTLY ASKED QUESTIONS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ..._translateQuestionsToWidgets(state.displayingQuestions),
            if (state.isSearching) _CancelSearchButton(),
          ],
        );
      },
    );
  }
}

class _CancelSearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: double.infinity,
      onPressed: () =>
          context.read<HowItWorksBloc>().add(DisplayingQuestionsReset()),
      child: Text(
        'Clear search',
        style: TextStyle(
          color: LiveFeedTheme.theme.highlightColor,
        ),
      ),
    );
  }
}

class _WhatIsLivefeedCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WhatIsLivefeedCardState();
}

class _WhatIsLivefeedCardState extends State<_WhatIsLivefeedCard> {
  bool _expanded = false;

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: DropCapText(
        'LiveFEED is a revolutionary platform that allows _everyone_ to share and monetize hyperlocal content worldwide. And by everyone, we mean _everyone_. Including You!',
        parseInlineMarkdown: true,
        dropCap: DropCap(
          width: 120,
          height: 75,
          child: Image.asset('assets/images/livefeed_logo_how3x.png'),
        ),
        dropCapPadding: EdgeInsets.only(
          right: 30,
        ),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          height: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[400],
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'What is LiveFEED?',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              trailing: FlatButton(
                minWidth: 5,
                height: 2,
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 5,
                ),
                color: LiveFeedTheme.theme.accentColor.withOpacity(0.2),
                child: Icon(
                  _expanded ? Icons.remove : Icons.add,
                  color: LiveFeedTheme.theme.accentColor,
                ),
              ),
            ),
            if (_expanded) _buildContent(),
          ],
        ),
      ),
    );
  }
}

class _MarketplaceHowToCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MarketplaceHowToCardState();
}

class _MarketplaceHowToCardState extends State<_MarketplaceHowToCard> {
  bool _expanded = false;

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'LiveFEED Marketplace is a where you can acquire or offer content. All content offered at the Marketplace is under non-exclusive license, permitting an acquirer a singular use.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[400],
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Marketplace How-to',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              trailing: FlatButton(
                minWidth: 5,
                height: 2,
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 5,
                ),
                color: LiveFeedTheme.theme.accentColor.withOpacity(0.2),
                child: Icon(
                  _expanded ? Icons.remove : Icons.add,
                  color: LiveFeedTheme.theme.accentColor,
                ),
              ),
            ),
            if (_expanded) _buildContent(),
          ],
        ),
      ),
    );
  }
}

class _HowToSignUpCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HowToSignUpCardState();
}

class _HowToSignUpCardState extends State<_HowToSignUpCard> {
  bool _expanded = false;

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 116,
            width: 198,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image(
                image: AssetImage('assets/images/sign_up_how3x.png'),
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.check,
            color: LiveFeedTheme.theme.accentColor,
          ),
          visualDensity: VisualDensity.compact,
          title: RichText(
            text: TextSpan(
              style: LiveFeedTheme.theme.textTheme.bodyText1
                  .copyWith(fontWeight: FontWeight.w600, height: 1.5),
              children: <TextSpan>[
                TextSpan(
                  text: 'Go to',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' www.getlivefeed.com',
                  style: TextStyle(
                    color: LiveFeedTheme.theme.highlightColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.check,
            color: LiveFeedTheme.theme.accentColor,
          ),
          visualDensity: VisualDensity.compact,
          title: RichText(
            text: TextSpan(
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Click',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' Sign up ',
                  style: TextStyle(
                    color: LiveFeedTheme.theme.highlightColor,
                  ),
                ),
                TextSpan(
                  text: 'at the top right corner of your screen',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.check,
            color: LiveFeedTheme.theme.accentColor,
          ),
          visualDensity: VisualDensity.compact,
          title: RichText(
            text: TextSpan(
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'You will be directed to the',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' Login ',
                  style: TextStyle(
                    color: LiveFeedTheme.theme.highlightColor,
                  ),
                ),
                TextSpan(
                  text: 'page.\nFill out all your information.\nClick Submit.',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.check,
            color: LiveFeedTheme.theme.accentColor,
          ),
          visualDensity: VisualDensity.compact,
          title: RichText(
            text: TextSpan(
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'You will receive a one-time password to your cell phone,\nwhich you will use to log in.',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[400],
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'How to sign up?',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              trailing: FlatButton(
                minWidth: 5,
                height: 2,
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 5,
                ),
                color: LiveFeedTheme.theme.accentColor.withOpacity(0.2),
                child: Icon(
                  _expanded ? Icons.remove : Icons.add,
                  color: LiveFeedTheme.theme.accentColor,
                ),
              ),
            ),
            if (_expanded) _buildContent(),
          ],
        ),
      ),
    );
  }
}

class _OtpInfoCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OtpInfoCardState();
}

class _OtpInfoCardState extends State<_OtpInfoCard> {
  bool _expanded = false;

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: DropCapText(
        'Short and simple.\n\n1. We\'re solving the fake news problem, which means LiveFEED is built for humans, not robots (sorry, bud 🤖 ).\n\n2. Your privacy and security are our top priorities. That’s why you get a new one-time password (OTP) sent to your phone every time you log in',
        dropCap: DropCap(
          width: 120,
          height: 75,
          child: Image.asset('assets/images/otp_how3x.png'),
        ),
        dropCapPadding: EdgeInsets.only(
          right: 30,
        ),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          height: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[400],
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                _expanded
                    ? 'Why are we using a one-time password and your cell phone instead of an old-school password on a sheet of paper?'
                    : 'Why are we using a one-time password?',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              trailing: FlatButton(
                minWidth: 5,
                height: 2,
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 5,
                ),
                color: LiveFeedTheme.theme.accentColor.withOpacity(0.2),
                child: Icon(
                  _expanded ? Icons.remove : Icons.add,
                  color: LiveFeedTheme.theme.accentColor,
                ),
              ),
            ),
            if (_expanded) _buildContent(),
          ],
        ),
      ),
    );
  }
}

class _UpdatePhoneNumberCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpdatePhoneNumberCardState();
}

class _UpdatePhoneNumberCardState extends State<_UpdatePhoneNumberCard> {
  bool _expanded = false;

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        // alignment: WrapAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 100,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image(
                image: AssetImage('assets/images/update_phone_how3x.png'),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 20)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: LiveFeedTheme.theme.accentColor,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  RichText(
                    text: TextSpan(
                      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(
                            color: LiveFeedTheme.theme.highlightColor,
                          ),
                        ),
                        TextSpan(
                          text: ' to your account',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: LiveFeedTheme.theme.accentColor,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  RichText(
                    text: TextSpan(
                      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Click "',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Edit my profile',
                          style: TextStyle(
                            color: LiveFeedTheme.theme.highlightColor,
                          ),
                        ),
                        TextSpan(
                          text: '".',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: LiveFeedTheme.theme.accentColor,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  RichText(
                    text: TextSpan(
                      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Update your profile',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[400],
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'How to update my phone number?',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              trailing: FlatButton(
                minWidth: 5,
                height: 2,
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 5,
                ),
                color: LiveFeedTheme.theme.accentColor.withOpacity(0.2),
                child: Icon(
                  _expanded ? Icons.remove : Icons.add,
                  color: LiveFeedTheme.theme.accentColor,
                ),
              ),
            ),
            if (_expanded) _buildContent(),
          ],
        ),
      ),
    );
  }
}

class _ContactUsCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactUsCardState();
}

class _ContactUsCardState extends State<_ContactUsCard> {
  bool _expanded = false;

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: DropCapText(
        'No worries! We got your back - just contact us here, and we’ll take care of it for you. We may need to ask you some security questions to protect your account from pirates.',
        dropCap: DropCap(
          width: 120,
          height: 75,
          child: Image.asset('assets/images/contact_us_how3x.png'),
        ),
        dropCapPadding: EdgeInsets.only(
          right: 30,
        ),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          height: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[400],
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'What if I don\'t have access to my phone number any longer?',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              trailing: FlatButton(
                minWidth: 5,
                height: 2,
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 5,
                ),
                color: LiveFeedTheme.theme.accentColor.withOpacity(0.2),
                child: Icon(
                  _expanded ? Icons.remove : Icons.add,
                  color: LiveFeedTheme.theme.accentColor,
                ),
              ),
            ),
            if (_expanded) _buildContent(),
          ],
        ),
      ),
    );
  }
}
