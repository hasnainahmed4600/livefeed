import 'dart:async';
import 'dart:math';

import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:livefeed/common/models/livefeed_post.dart';
import 'package:livefeed/theme.dart';
import 'package:chewie/chewie.dart';
import 'package:livefeed/timeline_list/bloc/timeline_list_bloc.dart';
import 'package:livefeed/timeline_post/screen/timeline_post_screen.dart';
import 'package:livefeed/common/widgets/video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimelinePostCard extends StatelessWidget {
  TimelinePostCard(this.post);

  final LiveFeedPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: post.seen ? Colors.white : Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 15)),
          _PostHeadline(post.id, post.postHeadline, post.seen),
          _CardHeader(post.userName, post.postDate, post.postLocation),
          const Padding(padding: EdgeInsets.only(top: 5)),
          _PostImage(post.assetPath),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'See more...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: LiveFeedTheme.theme.highlightColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
        ],
      ),
    );
  }
}

class TimelineVideoPostCard extends StatelessWidget {
  TimelineVideoPostCard(this.post, this.videoActive);

  final LiveFeedPost post;
  final bool videoActive;

  @override
  Widget build(BuildContext context) {
    print('Video post id: ${post.id}');
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: post.seen ? Colors.white : Colors.grey[200],
      ),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 15)),
          _PostHeadline(post.id, post.postHeadline, post.seen),
          _CardHeader(post.userName, post.postDate, post.postLocation),
          const Padding(padding: EdgeInsets.only(top: 5)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: LiveFeedVideoControl(
              videoActive,
              post.assetPath,
              post.videoAssetThumbnailUrl,
              postId: post.id,
              onPostVideoTapped: (value) {
                context.read<TimelineListBloc>().add(VideoPlayed(post.id));
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'See more...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: LiveFeedTheme.theme.highlightColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final String userName;
  final DateTime postDate;
  final String postLocation;

  _CardHeader(this.userName, this.postDate, this.postLocation);

  @override
  Widget build(BuildContext context) {
    var timeAgo = '';
    if (DateTime.now().difference(postDate).inMinutes <= 5) {
      timeAgo = 'Just now';
    } else if (DateTime.now().difference(postDate).inMinutes <= 59) {
      timeAgo = '${DateTime.now().difference(postDate).inMinutes} minutes ago';
    } else if (DateTime.now().difference(postDate).inHours < 24) {
      if (DateTime.now().difference(postDate).inHours > 1)
        timeAgo = '${DateTime.now().difference(postDate).inHours} hours ago';
      else
        timeAgo = '${DateTime.now().difference(postDate).inHours} hour ago';
    } else if (DateTime.now().difference(postDate).inHours > 24 &&
        DateTime.now().difference(postDate).inHours < 730.001) {
      if (DateTime.now().difference(postDate).inDays > 1)
        timeAgo = '${DateTime.now().difference(postDate).inDays} days ago';
      else
        timeAgo = '${DateTime.now().difference(postDate).inDays} day ago';
    } else {
      if (DateTime.now().difference(postDate).inDays / 30 > 1)
        timeAgo =
            '${DateTime.now().difference(postDate).inDays / 30} months ago';
      else
        timeAgo =
            '${DateTime.now().difference(postDate).inDays / 30} month ago';
    }

    String getInitials() {
      List<String> names = userName.split(' ');
      String initials = '';
      int numWords = 2;

      if (numWords < names.length) {
        numWords = names.length;
      }
      for (var i = 0; i < numWords; i++) {
        initials += '${names[i][0]}';
      }
      return initials;
    }

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Random().nextBool()
                  ? CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/sibabalwe.png'),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        getInitials(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                  const Padding(padding: EdgeInsets.only(left: 5)),
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
          ],
        ),
        Positioned(
          right: 16,
          top: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                timeAgo,
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PostHeadline extends StatelessWidget {
  final String postId;
  final String text;
  final bool seen;

  _PostHeadline(this.postId, this.text, this.seen);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(TimelinePostScreen.route(
          postId: postId,
          timelineListContext: context,
        )),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        // child: seen
        //     ? Text(
        //         text,
        //         style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
        //           fontWeight: FontWeight.w600,
        //           fontSize: 20,
        //         ),
        //       )
        //     : DropCapText(
        //         text,
        //         style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
        //           fontWeight: FontWeight.w600,
        //           fontSize: 20,
        //         ),
        //         dropCapPadding: EdgeInsets.only(right: 15),
        //         dropCapPosition: DropCapPosition.end,
        //         dropCap: DropCap(
        //           width: 1,
        //           height: 1,
        //           child: Icon(
        //             Icons.circle,
        //             color: LiveFeedTheme.theme.accentColor,
        //             size: 13,
        //           ),
        //         ),
        //       ),
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  final String imagePath;

  _PostImage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 170,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image(
            image: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }
}

// class _PostVideo extends StatefulWidget {
//   _PostVideo(this.videoLink);
//   final String videoLink;
//   @override
//   State<StatefulWidget> createState() => _PostVideoState(videoLink);
// }

// class _PostVideoState extends State<_PostVideo> {
//   _PostVideoState(this.videoLink);
//   final String videoLink;
//   VideoPlayerController _videoPlayerController;
//   ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }

//   Future<void> initializePlayer() async {
//     _videoPlayerController = VideoPlayerController.network(videoLink);
//     await _videoPlayerController.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: false,
//       looping: false,
//       allowPlaybackSpeedChanging: false,
//       allowMuting: true,
//       customControls: MaterialControls(),
//     );
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 15,
//       ),
//       child: _chewieController != null &&
//               _chewieController.videoPlayerController.value.isInitialized
//           ? Container(
//               height: 170,
//               width: double.infinity,
//               color: Colors.black,
//               child: Chewie(controller: _chewieController),
//             )
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 CircularProgressIndicator(),
//                 SizedBox(height: 20),
//                 Text('Loading'),
//               ],
//             ),
//     );
//   }
// }

// class MaterialControls extends StatefulWidget {
//   const MaterialControls({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _MaterialControlsState();
//   }
// }

// class _MaterialControlsState extends State<MaterialControls>
//     with SingleTickerProviderStateMixin {
//   VideoPlayerValue _latestValue;
//   double _latestVolume;
//   bool _hideStuff = true;
//   Timer _hideTimer;
//   Timer _initTimer;
//   Timer _showAfterExpandCollapseTimer;
//   bool _dragging = false;
//   bool _displayTapped = false;

//   final barHeight = 48.0;
//   final marginSize = 5.0;

//   VideoPlayerController controller;
//   ChewieController chewieController;
//   AnimationController playPauseIconAnimationController;

//   @override
//   Widget build(BuildContext context) {
//     if (_latestValue.hasError) {
//       return chewieController.errorBuilder != null
//           ? chewieController.errorBuilder(
//               context,
//               chewieController.videoPlayerController.value.errorDescription,
//             )
//           : const Center(
//               child: Icon(
//                 Icons.error,
//                 color: Colors.white,
//                 size: 42,
//               ),
//             );
//     }

//     return MouseRegion(
//       onHover: (_) {
//         _cancelAndRestartTimer();
//       },
//       child: GestureDetector(
//         onTap: () => _cancelAndRestartTimer(),
//         child: AbsorbPointer(
//           absorbing: _hideStuff,
//           child: Column(
//             children: <Widget>[
//               if (_latestValue != null &&
//                       !_latestValue.isPlaying &&
//                       _latestValue.duration == null ||
//                   _latestValue.isBuffering)
//                 const Expanded(
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 )
//               else
//                 _buildHitArea(),
//               _buildBottomBar(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _dispose();
//     super.dispose();
//   }

//   void _dispose() {
//     controller.removeListener(_updateState);
//     _hideTimer?.cancel();
//     _initTimer?.cancel();
//     _showAfterExpandCollapseTimer?.cancel();
//   }

//   @override
//   void didChangeDependencies() {
//     final _oldController = chewieController;
//     chewieController = ChewieController.of(context);
//     controller = chewieController.videoPlayerController;

//     playPauseIconAnimationController ??= AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//       reverseDuration: const Duration(milliseconds: 400),
//     );

//     if (_oldController != chewieController) {
//       _dispose();
//       _initialize();
//     }

//     super.didChangeDependencies();
//   }

//   AnimatedOpacity _buildBottomBar(
//     BuildContext context,
//   ) {
//     final iconColor = Theme.of(context).textTheme.button.color;

//     return AnimatedOpacity(
//       opacity: _hideStuff ? 0.0 : 1.0,
//       duration: const Duration(milliseconds: 300),
//       child: Container(
//         height: barHeight,
//         color: Colors.transparent,
//         child: Row(
//           children: <Widget>[
//             _buildPlayPause(controller),
//             if (chewieController.allowMuting) _buildMuteButton(controller),
//             if (chewieController.isLive)
//               const Expanded(child: Text('LIVE'))
//             else
//               _buildCurrentPosition(iconColor),
//             if (chewieController.isLive)
//               const SizedBox()
//             else
//               _buildProgressBar(),
//             if (!chewieController.isLive) _buildTotalDuration(iconColor),
//             _buildSettingsButton(),
//             if (chewieController.allowPlaybackSpeedChanging)
//               _buildSpeedButton(controller),
//             if (chewieController.allowFullScreen) _buildExpandButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   GestureDetector _buildExpandButton() {
//     return GestureDetector(
//       onTap: _onExpandCollapse,
//       child: AnimatedOpacity(
//         opacity: _hideStuff ? 0.0 : 1.0,
//         duration: const Duration(milliseconds: 300),
//         child: Container(
//           height: barHeight,
//           margin: const EdgeInsets.only(right: 12.0),
//           padding: const EdgeInsets.only(
//             left: 8.0,
//             right: 8.0,
//           ),
//           child: Center(
//             child: Icon(
//               chewieController.isFullScreen
//                   ? Icons.fullscreen_exit
//                   : Icons.fullscreen,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   GestureDetector _buildSettingsButton() {
//     return GestureDetector(
//       onTap: _onExpandCollapse,
//       child: Stack(
//         children: [
//           Container(
//             height: barHeight,
//             padding: const EdgeInsets.only(
//               left: 8.0,
//               right: 2.0,
//             ),
//             child: Center(
//               child: Icon(
//                 Icons.settings,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 10,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4.0),
//                 border: Border.all(width: 1.0, color: Colors.grey[400]),
//                 color: Colors.red,
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 5,
//                   vertical: 2,
//                 ),
//                 child: Text(
//                   'AUTO',
//                   style: TextStyle(
//                     fontSize: 8,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Expanded _buildHitArea() {
//     final bool isFinished = _latestValue.position >= _latestValue.duration;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           if (_latestValue != null && _latestValue.isPlaying) {
//             if (_displayTapped) {
//               setState(() {
//                 _hideStuff = true;
//               });
//             } else {
//               _cancelAndRestartTimer();
//             }
//           } else {
//             _playPause();

//             setState(() {
//               _hideStuff = true;
//             });
//           }
//         },
//         child: Padding(
//           padding: EdgeInsets.only(
//             top: 20,
//           ),
//           child: Container(
//             color: Colors.transparent,
//             child: Center(
//               child: AnimatedOpacity(
//                 opacity: _latestValue != null &&
//                         !_latestValue.isPlaying &&
//                         !_dragging
//                     ? 1.0
//                     : 0.0,
//                 duration: const Duration(milliseconds: 300),
//                 child: GestureDetector(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(48.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: IconButton(
//                           iconSize: 90,
//                           icon: isFinished
//                               ? Icon(
//                                   Icons.replay,
//                                   // size: 90.0,
//                                   color: LiveFeedTheme.theme.accentColor,
//                                 )
//                               : AnimatedIcon(
//                                   icon: AnimatedIcons.play_pause,
//                                   progress: playPauseIconAnimationController,
//                                   // size: 90.0,
//                                   color: LiveFeedTheme.theme.accentColor,
//                                 ),
//                           onPressed: () {
//                             _playPause();
//                           }),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSpeedButton(
//     VideoPlayerController controller,
//   ) {
//     return GestureDetector(
//       onTap: () async {
//         _hideTimer?.cancel();

//         final chosenSpeed = await showModalBottomSheet<double>(
//           context: context,
//           isScrollControlled: true,
//           useRootNavigator: true,
//           builder: (context) => _PlaybackSpeedDialog(
//             speeds: chewieController.playbackSpeeds,
//             selected: _latestValue.playbackSpeed,
//           ),
//         );

//         if (chosenSpeed != null) {
//           controller.setPlaybackSpeed(chosenSpeed);
//         }

//         if (_latestValue.isPlaying) {
//           _startHideTimer();
//         }
//       },
//       child: AnimatedOpacity(
//         opacity: _hideStuff ? 0.0 : 1.0,
//         duration: const Duration(milliseconds: 300),
//         child: ClipRect(
//           child: Container(
//             height: barHeight,
//             padding: const EdgeInsets.only(
//               left: 8.0,
//               right: 8.0,
//             ),
//             child: const Icon(Icons.speed),
//           ),
//         ),
//       ),
//     );
//   }

//   GestureDetector _buildMuteButton(
//     VideoPlayerController controller,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         _cancelAndRestartTimer();

//         if (_latestValue.volume == 0) {
//           controller.setVolume(_latestVolume ?? 0.5);
//         } else {
//           _latestVolume = controller.value.volume;
//           controller.setVolume(0.0);
//         }
//       },
//       child: AnimatedOpacity(
//         opacity: _hideStuff ? 0.0 : 1.0,
//         duration: const Duration(milliseconds: 300),
//         child: ClipRect(
//           child: Container(
//             height: barHeight,
//             padding: const EdgeInsets.only(
//               left: 8.0,
//               right: 8.0,
//             ),
//             child: Icon(
//               (_latestValue != null && _latestValue.volume > 0)
//                   ? Icons.volume_up
//                   : Icons.volume_off,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   GestureDetector _buildPlayPause(VideoPlayerController controller) {
//     return GestureDetector(
//       onTap: _playPause,
//       child: Container(
//         height: barHeight,
//         color: Colors.transparent,
//         margin: const EdgeInsets.only(left: 8.0, right: 4.0),
//         padding: const EdgeInsets.only(
//           left: 12.0,
//           right: 3.0,
//         ),
//         child: Icon(
//           controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   Widget _buildCurrentPosition(Color iconColor) {
//     final position = _latestValue != null && _latestValue.position != null
//         ? _latestValue.position
//         : Duration.zero;
//     final duration = _latestValue != null && _latestValue.duration != null
//         ? _latestValue.duration
//         : Duration.zero;

//     return Padding(
//       padding: const EdgeInsets.only(right: 12.0),
//       child: Text(
//         '${formatDuration(position)}',
//         style: const TextStyle(
//           fontSize: 14.0,
//           color: Colors.white,
//           fontFamily: 'Roboto',
//         ),
//       ),
//     );
//   }

//   Widget _buildTotalDuration(Color iconColor) {
//     final position = _latestValue != null && _latestValue.position != null
//         ? _latestValue.position
//         : Duration.zero;
//     final duration = _latestValue != null && _latestValue.duration != null
//         ? _latestValue.duration
//         : Duration.zero;

//     return Padding(
//       padding: const EdgeInsets.only(),
//       child: Text(
//         '${formatDuration(duration)}',
//         style: const TextStyle(
//           fontSize: 14.0,
//           color: Colors.white,
//           fontFamily: 'Roboto',
//         ),
//       ),
//     );
//   }

//   void _cancelAndRestartTimer() {
//     _hideTimer?.cancel();
//     _startHideTimer();

//     setState(() {
//       _hideStuff = false;
//       _displayTapped = true;
//     });
//   }

//   Future<void> _initialize() async {
//     controller.addListener(_updateState);

//     _updateState();

//     if ((controller.value != null && controller.value.isPlaying) ||
//         chewieController.autoPlay) {
//       _startHideTimer();
//     }

//     if (chewieController.showControlsOnInitialize) {
//       _initTimer = Timer(const Duration(milliseconds: 200), () {
//         setState(() {
//           _hideStuff = false;
//         });
//       });
//     }
//   }

//   void _onExpandCollapse() {
//     setState(() {
//       _hideStuff = true;

//       chewieController.toggleFullScreen();
//       _showAfterExpandCollapseTimer =
//           Timer(const Duration(milliseconds: 300), () {
//         setState(() {
//           _cancelAndRestartTimer();
//         });
//       });
//     });
//   }

//   void _playPause() {
//     bool isFinished;
//     if (_latestValue.duration != null) {
//       isFinished = _latestValue.position >= _latestValue.duration;
//     } else {
//       isFinished = false;
//     }

//     setState(() {
//       if (controller.value.isPlaying) {
//         playPauseIconAnimationController.reverse();
//         _hideStuff = false;
//         _hideTimer?.cancel();
//         controller.pause();
//       } else {
//         _cancelAndRestartTimer();

//         if (!controller.value.isInitialized) {
//           controller.initialize().then((_) {
//             controller.play();
//             playPauseIconAnimationController.forward();
//           });
//         } else {
//           if (isFinished) {
//             controller.seekTo(const Duration());
//           }
//           playPauseIconAnimationController.forward();
//           controller.play();
//         }
//       }
//     });
//   }

//   void _startHideTimer() {
//     _hideTimer = Timer(const Duration(seconds: 3), () {
//       setState(() {
//         _hideStuff = true;
//       });
//     });
//   }

//   void _updateState() {
//     setState(() {
//       _latestValue = controller.value;
//     });
//   }

//   Widget _buildProgressBar() {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 12.0),
//         child: MaterialVideoProgressBar(
//           controller,
//           onDragStart: () {
//             setState(() {
//               _dragging = true;
//             });

//             _hideTimer?.cancel();
//           },
//           onDragEnd: () {
//             setState(() {
//               _dragging = false;
//             });

//             _startHideTimer();
//           },
//           colors: chewieController.materialProgressColors ??
//               ChewieProgressColors(
//                 playedColor: Colors.red[700],
//                 handleColor: Colors.white,
//                 bufferedColor: Colors.transparent,
//                 backgroundColor: Colors.transparent,
//               ),
//         ),
//       ),
//     );
//   }
// }

// class _PlaybackSpeedDialog extends StatelessWidget {
//   const _PlaybackSpeedDialog({
//     Key key,
//     @required List<double> speeds,
//     @required double selected,
//   })  : _speeds = speeds,
//         _selected = selected,
//         super(key: key);

//   final List<double> _speeds;
//   final double _selected;

//   @override
//   Widget build(BuildContext context) {
//     final Color selectedColor = Theme.of(context).primaryColor;

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const ScrollPhysics(),
//       itemBuilder: (context, index) {
//         final _speed = _speeds[index];
//         return ListTile(
//           dense: true,
//           title: Row(
//             children: [
//               if (_speed == _selected)
//                 Icon(
//                   Icons.check,
//                   size: 20.0,
//                   color: selectedColor,
//                 )
//               else
//                 Container(width: 20.0),
//               const SizedBox(width: 16.0),
//               Text(_speed.toString()),
//             ],
//           ),
//           selected: _speed == _selected,
//           onTap: () {
//             Navigator.of(context).pop(_speed);
//           },
//         );
//       },
//       itemCount: _speeds.length,
//     );
//   }
// }

// class MaterialVideoProgressBar extends StatefulWidget {
//   MaterialVideoProgressBar(
//     this.controller, {
//     ChewieProgressColors colors,
//     this.onDragEnd,
//     this.onDragStart,
//     this.onDragUpdate,
//     Key key,
//   })  : colors = colors ?? ChewieProgressColors(),
//         super(key: key);

//   final VideoPlayerController controller;
//   final ChewieProgressColors colors;
//   final Function() onDragStart;
//   final Function() onDragEnd;
//   final Function() onDragUpdate;

//   @override
//   _VideoProgressBarState createState() {
//     return _VideoProgressBarState();
//   }
// }

// class _VideoProgressBarState extends State<MaterialVideoProgressBar> {
//   _VideoProgressBarState() {
//     listener = () {
//       if (!mounted) return;
//       setState(() {});
//     };
//   }

//   VoidCallback listener;
//   bool _controllerWasPlaying = false;

//   VideoPlayerController get controller => widget.controller;

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(listener);
//   }

//   @override
//   void deactivate() {
//     controller.removeListener(listener);
//     super.deactivate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     void seekToRelativePosition(Offset globalPosition) {
//       final box = context.findRenderObject() as RenderBox;
//       final Offset tapPos = box.globalToLocal(globalPosition);
//       final double relative = tapPos.dx / box.size.width;
//       final Duration position = controller.value.duration * relative;
//       controller.seekTo(position);
//     }

//     return GestureDetector(
//       onHorizontalDragStart: (DragStartDetails details) {
//         if (!controller.value.isInitialized) {
//           return;
//         }
//         _controllerWasPlaying = controller.value.isPlaying;
//         if (_controllerWasPlaying) {
//           controller.pause();
//         }

//         if (widget.onDragStart != null) {
//           widget.onDragStart();
//         }
//       },
//       onHorizontalDragUpdate: (DragUpdateDetails details) {
//         if (!controller.value.isInitialized) {
//           return;
//         }
//         seekToRelativePosition(details.globalPosition);

//         if (widget.onDragUpdate != null) {
//           widget.onDragUpdate();
//         }
//       },
//       onHorizontalDragEnd: (DragEndDetails details) {
//         if (_controllerWasPlaying) {
//           controller.play();
//         }

//         if (widget.onDragEnd != null) {
//           widget.onDragEnd();
//         }
//       },
//       onTapDown: (TapDownDetails details) {
//         if (!controller.value.isInitialized) {
//           return;
//         }
//         seekToRelativePosition(details.globalPosition);
//       },
//       child: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height / 2,
//           width: MediaQuery.of(context).size.width,
//           color: Colors.transparent,
//           child: CustomPaint(
//             painter: _ProgressBarPainter(
//               controller.value,
//               widget.colors,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ProgressBarPainter extends CustomPainter {
//   _ProgressBarPainter(this.value, this.colors)
//       : smallHandlePaint = Paint()..color = Colors.black;

//   VideoPlayerValue value;
//   ChewieProgressColors colors;
//   final Paint smallHandlePaint;

//   @override
//   bool shouldRepaint(CustomPainter painter) {
//     return true;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     const height = 12.0;

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromPoints(
//           Offset(0.0, size.height / 2),
//           Offset(size.width, size.height / 2 + height),
//         ),
//         const Radius.circular(4.0),
//       ),
//       colors.backgroundPaint,
//     );
//     if (!value.isInitialized) {
//       return;
//     }
//     final double playedPartPercent =
//         value.position.inMilliseconds / value.duration.inMilliseconds;
//     final double playedPart =
//         playedPartPercent > 1 ? size.width : playedPartPercent * size.width;
//     for (final DurationRange range in value.buffered) {
//       final double start = range.startFraction(value.duration) * size.width;
//       final double end = range.endFraction(value.duration) * size.width;
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromPoints(
//             Offset(start, size.height / 2),
//             Offset(end, size.height / 2 + height),
//           ),
//           const Radius.circular(4.0),
//         ),
//         colors.bufferedPaint,
//       );
//     }
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromPoints(
//           Offset(0.0, size.height / 2.5),
//           Offset(playedPart, size.height / 2.5 + height),
//         ),
//         const Radius.circular(4.0),
//       ),
//       colors.playedPaint,
//     );
//     var outlinePaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..color = Colors.grey;
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromPoints(
//           Offset(0.0, size.height / 2.5),
//           Offset(size.width, size.height / 2.5 + height),
//         ),
//         const Radius.circular(4.0),
//       ),
//       outlinePaint,
//     );
//     canvas.drawCircle(
//       Offset(playedPart, size.height / 2.5 + height / 2),
//       height * 0.9,
//       colors.handlePaint,
//     );
//     canvas.drawCircle(
//       Offset(playedPart, size.height / 2.5 + height / 2),
//       height * 0.35,
//       smallHandlePaint,
//     );
//   }
// }

// String formatDuration(Duration position) {
//   final ms = position.inMilliseconds;

//   int seconds = ms ~/ 1000;
//   final int hours = seconds ~/ 3600;
//   seconds = seconds % 3600;
//   final minutes = seconds ~/ 60;
//   seconds = seconds % 60;

//   final hoursString = hours >= 10
//       ? '$hours'
//       : hours == 0
//           ? '00'
//           : '0$hours';

//   final minutesString = minutes >= 10
//       ? '$minutes'
//       : minutes == 0
//           ? '00'
//           : '0$minutes';

//   final secondsString = seconds >= 10
//       ? '$seconds'
//       : seconds == 0
//           ? '00'
//           : '0$seconds';

//   final formattedTime =
//       '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';

//   return formattedTime;
// }
