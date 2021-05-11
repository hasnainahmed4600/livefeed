import 'package:flutter/material.dart';
import 'package:livefeed/edit_post/screen/edit_post_screen.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/timeline_list/screen/ad_poster.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailCard extends StatelessWidget {
  PostDetailCard({
    this.postId = '60606 - A16CD',
    this.postHeadline =
        'Half of States Move to Partially Reopen as Coronavirus Death Toll Climbs Past 63,000',
    this.postCategory = 'Politics',
    this.postUserName = 'Sibabalwe Rubusana',
    DateTime postDate,
    DateTime lastContributionDate,
    this.postLocation = 'Chicago, IL 60606 (5 miles from you)',
    this.postDescription =
        'In Michigan, protesters – some of whom were armed – entered the state Capitol on Thursday to criticize the state\'s emergency declaration. Republican lawmakers declined to extend the declaration and voted to legally challenge the Democratic governor\'s executive actions to fight the pandemic. Gov. Gretchen Whitmer proceeded to extend the order without the legislature\'s approval.',
    this.postUpvotes = 999,
    this.postDownvotes = 5,
  })  : _postDate = postDate ??
            DateTime(DateTime.now().year, DateTime.now().month - 3,
                DateTime.now().day - 2),
        _lastContributionDate = lastContributionDate ??
            DateTime(DateTime.now().year, DateTime.now().month - 2,
                DateTime.now().day - 4);

  final String postId;
  final String postHeadline;
  final String postCategory;
  final String postUserName;
  final DateTime _postDate;
  final DateTime _lastContributionDate;
  final String postLocation;
  final String postDescription;
  final int postUpvotes;
  final int postDownvotes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              _CardHeader(
                postHeadline,
                postCategory,
                postUserName,
                _postDate,
                _lastContributionDate,
                postLocation,
              ),
              _PostImages(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  postDescription,
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                ),
              ),
              _VoteDisplay(
                  postUpvotes, postDownvotes, _UserVoteType.unselected),
              _Footer(postId),
              const Padding(padding: EdgeInsets.only(top: 10)),
              _SocialMediaLinks(
                initialHeadline: postHeadline.substring(0, 70),
                initialDescription: postDescription,
                initialCategory: postCategory,
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 10, right: 12, bottom: 10),
                child: AdPoster(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final String headline;
  final String postCategory;
  final String userName;
  final DateTime createdDate;
  final DateTime lastContributionDate;
  final String postLocation;
  _CardHeader(
    this.headline,
    this.postCategory,
    this.userName,
    this.createdDate,
    this.lastContributionDate,
    this.postLocation,
  );

  String renderTimeAgoString(String prefix, DateTime comparisonDate) {
    if (DateTime.now().difference(comparisonDate).inMinutes <= 5) {
      return '$prefix just now';
    } else if (DateTime.now().difference(comparisonDate).inMinutes <= 59) {
      return '$prefix ${DateTime.now().difference(comparisonDate).inMinutes} minutes ago';
    } else if (DateTime.now().difference(comparisonDate).inHours < 24) {
      if (DateTime.now().difference(comparisonDate).inHours > 1)
        return '$prefix ${DateTime.now().difference(comparisonDate).inHours.round()} hours ago';
      else
        return '$prefix ${DateTime.now().difference(comparisonDate).inHours.round()} hour ago';
    } else if (DateTime.now().difference(comparisonDate).inHours > 24 &&
        DateTime.now().difference(comparisonDate).inHours < 730.001) {
      if (DateTime.now().difference(comparisonDate).inDays > 1)
        return '$prefix ${DateTime.now().difference(comparisonDate).inDays.round()} days ago';
      else
        return '$prefix ${DateTime.now().difference(comparisonDate).inDays.round()} day ago';
    } else {
      if (DateTime.now().difference(comparisonDate).inDays / 30 > 1)
        return '$prefix ${(DateTime.now().difference(comparisonDate).inDays / 30).round()} months ago';
      else
        return '$prefix ${(DateTime.now().difference(comparisonDate).inDays / 30).round()} month ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    var postTimeAgo = renderTimeAgoString('', createdDate);
    var contributionTimeAgo =
        renderTimeAgoString('Last updated', lastContributionDate);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            headline,
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                postCategory.toUpperCase(),
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  color: LiveFeedTheme.theme.highlightColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                contributionTimeAgo,
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/sibabalwe.png'),
              ),
              title: Text(
                userName,
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: LiveFeedTheme.theme.highlightColor,
                    size: 15,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 2)),
                  Text(
                    postLocation,
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.w500,
                      color: LiveFeedTheme.theme.highlightColor,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            Positioned(
              right: 10,
              top: 18,
              child: Text(
                postTimeAgo,
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PostImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 5,
      ),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: _ImagesContainer(),
          ),
          Positioned(
            top: 10,
            right: 0,
            child: _PaperClip('First reported'),
          ),
        ],
      ),
    );
  }
}

class _ImagesContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImagesContainerState();
}

class _ImagesContainerState extends State<_ImagesContainer> {
  final List<String> imagePaths = [
    'assets/images/medicine_guy.png',
    'assets/images/shoes.png',
    'assets/images/earth.png',
  ];
  int currentImageIndex = 1;

  void goToNextImage() {
    setState(() {
      if (imagePaths.length - 1 == currentImageIndex) {
        currentImageIndex = 0;
      } else {
        currentImageIndex += 1;
      }
    });
  }

  void goToPreviousImage() {
    setState(() {
      if (currentImageIndex == 0) {
        currentImageIndex = imagePaths.length - 1;
      } else {
        currentImageIndex -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 185,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image(
              image: AssetImage(
                imagePaths[currentImageIndex],
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.09,
          child: IconButton(
            onPressed: () {
              goToPreviousImage();
            },
            icon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            color: Colors.white,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.09,
          right: 0,
          child: IconButton(
            onPressed: () {
              goToNextImage();
            },
            icon: Icon(
              Icons.chevron_right,
              size: 30,
            ),
            color: Colors.white,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _LivefeedRatingPlate(7.0),
        ),
      ],
    );
  }
}

class _LivefeedRatingPlate extends StatelessWidget {
  final double _rating;
  const _LivefeedRatingPlate(rating)
      : assert(rating <= 10.0),
        assert(rating >= 0.0),
        _rating = rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
        ),
        border: Border.all(width: 1.0, color: Colors.transparent),
        color: Colors.white30.withOpacity(0.9),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Row(
          children: [
            _RatingGauge(_rating),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _rating.toString(),
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(126, 211, 33, 1),
                  ),
                ),
                Text(
                  'LiveFEED Rating™',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingGauge extends StatelessWidget {
  final double _rating;
  const _RatingGauge(rating)
      : assert(rating <= 10.0),
        assert(rating >= 0.0),
        _rating = rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5),
      child: SizedBox(
        width: 55,
        height: 40,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 10,
              startAngle: 180,
              endAngle: 0,
              interval: 1,
              canScaleToFit: true,
              showLabels: false,
              showTicks: false,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 10,
                  endWidth: 8,
                  startWidth: 8,
                  gradient: const SweepGradient(
                    colors: <Color>[
                      Colors.red,
                      Colors.yellow,
                      Colors.green,
                    ],
                    stops: <double>[
                      0.25,
                      0.50,
                      0.95,
                    ],
                  ),
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: _rating,
                  needleEndWidth: 2,
                  needleStartWidth: 0.2,
                  knobStyle: KnobStyle(knobRadius: 0.1),
                ),
              ],
              // annotations: <GaugeAnnotation>[
              //   GaugeAnnotation(
              //     widget: Container(
              //       child: Text(
              //         '7.0',
              //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //     angle: 7,
              //     positionFactor: 0.5,
              //   ),
              // ],
            )
          ],
        ),
      ),
    );
  }
}

class _PaperClip extends StatelessWidget {
  final String labelText;
  _PaperClip(this.labelText);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomPaint(
          painter: _PaperClipTriangle(
            strokeColor: Colors.grey[300],
            strokeWidth: 10,
            paintingStyle: PaintingStyle.fill,
          ),
          child: Container(
            height: 10,
            width: 10,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            border: Border.all(width: 1.0, color: Colors.grey[400]),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: Text(
              labelText,
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _PaperClipTriangle extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  _PaperClipTriangle({
    this.strokeColor = Colors.black,
    this.strokeWidth = 3,
    this.paintingStyle = PaintingStyle.fill,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      // ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(_PaperClipTriangle oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

enum _UserVoteType { unselected, upvoted, downvoted }

class _VoteDisplay extends StatefulWidget {
  final int initialUpvotes;
  final int initialDownvotes;
  final _UserVoteType initialVoteType;

  _VoteDisplay(
    this.initialUpvotes,
    this.initialDownvotes,
    this.initialVoteType,
  );
  @override
  State<StatefulWidget> createState() =>
      _VoteDisplayState(initialUpvotes, initialDownvotes, initialVoteType);
}

class _VoteDisplayState extends State<_VoteDisplay> {
  final int initialUpvotes;
  final int initialDownvotes;
  final _UserVoteType initialVoteType;
  int _currentUpvotes;
  int _currentDownvotes;
  _UserVoteType _currentVoteType;
  final nFormat = new NumberFormat.compact();

  _VoteDisplayState(
    this.initialUpvotes,
    this.initialDownvotes,
    this.initialVoteType,
  );

  @override
  void initState() {
    _currentUpvotes = initialUpvotes;
    _currentDownvotes = initialDownvotes;
    _currentVoteType = initialVoteType;
    super.initState();
  }

  void upVote() {
    if (_currentVoteType == _UserVoteType.upvoted) {
      setState(() {
        _currentVoteType = _UserVoteType.unselected;
        _currentUpvotes -= 1;
      });
    } else if (_currentVoteType == _UserVoteType.downvoted) {
      setState(() {
        _currentVoteType = _UserVoteType.upvoted;
        _currentDownvotes -= 1;
        _currentUpvotes += 1;
      });
    } else if (_currentVoteType == _UserVoteType.unselected) {
      setState(() {
        _currentVoteType = _UserVoteType.upvoted;
        _currentUpvotes += 1;
      });
    }
  }

  void downVote() {
    if (_currentVoteType == _UserVoteType.downvoted) {
      setState(() {
        _currentVoteType = _UserVoteType.unselected;
        _currentDownvotes -= 1;
      });
    } else if (_currentVoteType == _UserVoteType.upvoted) {
      setState(() {
        _currentVoteType = _UserVoteType.downvoted;
        _currentDownvotes += 1;
        _currentUpvotes -= 1;
      });
    } else if (_currentVoteType == _UserVoteType.unselected) {
      setState(() {
        _currentVoteType = _UserVoteType.downvoted;
        _currentDownvotes += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => upVote(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: _currentVoteType == _UserVoteType.upvoted
                    ? LiveFeedTheme.theme.highlightColor
                    : Colors.grey[400],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: _currentVoteType == _UserVoteType.upvoted
                          ? Colors.white
                          : Colors.black,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      '${nFormat.format(_currentUpvotes)} Upvotes',
                      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _currentVoteType == _UserVoteType.upvoted
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
          ),
          GestureDetector(
            onTap: () => downVote(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: _currentVoteType == _UserVoteType.downvoted
                    ? LiveFeedTheme.theme.highlightColor
                    : Colors.grey[400],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_down,
                      color: _currentVoteType == _UserVoteType.downvoted
                          ? Colors.white
                          : Colors.black,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      '${nFormat.format(_currentDownvotes)} Downvotes',
                      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _currentVoteType == _UserVoteType.downvoted
                            ? Colors.white
                            : Colors.black,
                      ),
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

class _Footer extends StatelessWidget {
  final String postId;
  _Footer(this.postId);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Post ID : $postId'),
        ],
      ),
    );
  }
}

class _SocialMediaLinks extends StatelessWidget {
  final String initialHeadline;
  final String initialDescription;
  final String initialCategory;
  final double _iconsPadding = 7;
  _SocialMediaLinks({
    this.initialHeadline,
    this.initialDescription,
    this.initialCategory,
  });
  _launchFacebookURL() async {
    const url = 'https://facebook.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchTwitterURL() async {
    const url = 'https://twitter.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchInstagramURL() async {
    const url = 'https://instagram.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchRedditURL() async {
    const url = 'https://reddit.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchEmailUrl() async {
    // TODO: Update and use contact pickers once issue is resolved: https://stackoverflow.com/questions/65661379/i-always-fail-to-run-with-an-error-description-in-the-flutter-contact-picker
    // final EmailContact contact = await FlutterContactPicker.pickEmailContact();
    final Uri params = Uri(
      scheme: 'mailto',
      // path: contact.email.email,
      query:
          'subject=LiveFEED Invitation&body=https://livefeed.com/autogenereated/link', //add subject and body here
    );
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchSmsUrl() async {
    final Uri params = Uri(
      scheme: 'sms',
      // path: 'email@example.com',
      query:
          'subject=LiveFEED Invitation&body=https://livefeed.com/autogenereated/link', //add subject and body here
    );
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('WARNING!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deleting a post is an irreversible action.'),
                Text('Are you sure you want to continue?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              GestureDetector(
                onTap: () => _launchFacebookURL(),
                child: Container(
                  width: 26,
                  height: 26,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image(
                      image: AssetImage(
                        'assets/images/facebook_icon3x.png',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: _iconsPadding)),
              GestureDetector(
                onTap: () => _launchTwitterURL(),
                child: Container(
                  width: 30,
                  height: 26,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image(
                      image: AssetImage(
                        'assets/images/twitter_icon3x.png',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: _iconsPadding)),
              GestureDetector(
                onTap: () => _launchInstagramURL(),
                child: Container(
                  width: 25,
                  height: 25,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image(
                      image: AssetImage(
                        'assets/images/instagram_icon3x.png',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: _iconsPadding)),
              GestureDetector(
                onTap: () => _launchRedditURL(),
                child: Container(
                  width: 25,
                  height: 25,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image(
                      image: AssetImage(
                        'assets/images/reddit_icon3x.png',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: _iconsPadding)),
              GestureDetector(
                onTap: () => _launchEmailUrl(),
                child: Icon(
                  Icons.email_outlined,
                  color: LiveFeedTheme.theme.highlightColor,
                  size: 26,
                ),
              ),
              Padding(padding: EdgeInsets.only(left: _iconsPadding)),
              GestureDetector(
                onTap: () => _launchSmsUrl(),
                child: Icon(
                  Icons.message_outlined,
                  color: LiveFeedTheme.theme.highlightColor,
                  size: 26,
                ),
              ),
            ],
          ),
          Container(
            child: Wrap(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(EditPostScreen.route(
                    initialHeadline,
                    initialDescription,
                    initialCategory,
                  )),
                  child: Text('EDIT'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text('|'),
                ),
                GestureDetector(
                  onTap: () => _showMyDialog(context),
                  child: Text('DELETE'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
