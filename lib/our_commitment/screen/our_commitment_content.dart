import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:livefeed/common/widgets/video_player.dart';
import 'package:livefeed/signup/screen/signup_feature.dart';
import 'package:livefeed/signup/screen/signup_screen.dart';
import 'package:livefeed/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class OurCommitmentContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OurCommitmentContentState();
}

class _OurCommitmentContentState extends State<OurCommitmentContent> {
  final String videoImagePath = 'assets/images/shoes3x.png';
  final String videoLink = 'https://youtu.be/9gClvo7mjjk';
  bool videoActive = false;
  // YoutubePlayerController _controller = YoutubePlayerController(
  //   initialVideoId: '9gClvo7mjjk',
  //   flags: YoutubePlayerFlags(
  //     autoPlay: false,
  //     mute: false,
  //   ),
  // );

  Widget _buildImage() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(videoImagePath),
        ),
      ),
    );
  }

  // Widget _buildYoutubePlayer() {
  //   return YoutubePlayer(
  //     controller: _controller,
  //     showVideoProgressIndicator: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          _DescriptionText(),
          const Padding(padding: EdgeInsets.only(top: 10)),
          LiveFeedVideoControl(
            videoActive,
            videoLink,
            videoImagePath,
            onPostVideoTapped: (value) {
              setState(() {
                videoActive = !videoActive;
              });
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          _CommitmentBody(),
        ],
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          'At LiveFEED, we change the world of information every day, and invite You to become a part of it!',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.5,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class _CommitmentBody extends StatelessWidget {
  Widget _buildItem(String textBody) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          color: LiveFeedTheme.theme.accentColor,
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Expanded(
          child: Text(
            textBody,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRichTextItem(List<TextSpan> textBody) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          color: LiveFeedTheme.theme.accentColor,
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.5,
                fontSize: 15,
              ),
              children: textBody,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Here’s our commitment to You:\n',
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
            _buildItem('We never sell your personal information.'),
            _buildItem('We focus on solving issues, not cultivating them'),
            _buildRichTextItem(
              <TextSpan>[
                TextSpan(text: 'Our mission is to fight '),
                TextSpan(
                  text: 'fake news ',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launch(
                        'https://www.forbes.com/sites/traversmark/2020/03/21/facebook-spreads-fake-news-faster-than-any-other-social-website-according-to-new-research/#795576146e1a'),
                ),
                TextSpan(text: 'and eliminate '),
                TextSpan(
                  text: 'news deserts',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launch('https://www.usnewsdeserts.com/'),
                ),
                TextSpan(text: '. Check out our '),
                TextSpan(
                  text: 'platform ',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launch('https://www.getlivefeed.com/'),
                ),
                TextSpan(
                    text:
                        'For some of the incredible features dedicated to that, with even more to come!'),
              ],
            ),
            _buildItem(
                'Our goal is to create freedom of speech for everyone all over the world.'),
            _buildItem('Our motto is news as it happens.'),
            _buildItem(
                'We always put You first. After all, you are the primary source of all information.'),
            _buildItem(
                'We provide a free, open, and safe place for information exchange and discussion.'),
            _buildItem(
                'Different opinions are encouraged, and everyone can share it through our LiveFEED.'),
            _buildRichTextItem(
              <TextSpan>[
                TextSpan(text: 'Each of our users is a reporter. '),
                TextSpan(
                  text: 'Sign up ',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Navigator.of(context).push(SignupFeature.route()),
                ),
                TextSpan(
                    text:
                        'for a free account and change the world of information!'),
              ],
            ),
            _buildItem(
                'We base our coverage solely on facts, and not the bias.'),
            _buildRichTextItem(
              <TextSpan>[
                TextSpan(
                    text:
                        'We\'re available for you 24/7. Have anything to add or share? Drop us a note, or '),
                TextSpan(
                  text: 'sign up ',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Navigator.of(context).push(SignupFeature.route()),
                ),
                TextSpan(
                    text:
                        'for your FREE account, and post directly to our LiveFEED!'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
