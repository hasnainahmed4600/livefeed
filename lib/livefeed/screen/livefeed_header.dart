import 'package:flutter/material.dart';
import 'package:livefeed/livefeed/bloc/livefeed_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/theme.dart';

class LivefeedHeader extends StatelessWidget {
  LivefeedHeader({
    @required this.onScrollToTopTapped,
  });
  final Function onScrollToTopTapped;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LivefeedBloc, LivefeedState>(
      // buildWhen: (previous, current) =>
      //     previous.withinRollInThreshold != current.withinRollInThreshold,
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 12,
              ),
              title: Text(
                'LiveFEED',
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: _BlinkingLivefeedButton(),
            ),
            if (state.unrenderedTopPostsAvailable &&
                !state.withinTopRollInThreshold)
              FlatButton(
                onPressed: onScrollToTopTapped,
                minWidth: double.infinity,
                child: Text(
                  'New posts just got in. Check them out!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _BlinkingLivefeedButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BlinkingLivefeedButtonState();
}

class _BlinkingLivefeedButtonState extends State<_BlinkingLivefeedButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 400));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Color.fromRGBO(255, 0, 0, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      height: 30,
      minWidth: 48,
      onPressed: () {},
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5.0,
        children: [
          FadeTransition(
            opacity: _animationController,
            child: Icon(
              Icons.circle,
              size: 10,
              color: Colors.white,
            ),
          ),
          Text(
            'LIVE',
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
