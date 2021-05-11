import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:livefeed/common/models/selected_media_file.dart';
import 'package:livefeed/theme.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/authentication/bloc/authentication_bloc.dart';

class LiveFeedVideoControl extends StatelessWidget {
  final String postId;
  final bool active;
  final String videoLink;
  final String thumbnailLink;
  final SelectedMediaFile _selectedVideo;
  final double height;
  final Function(String id) onPostVideoTapped;
  final bool showWatermark;

  LiveFeedVideoControl(
    this.active,
    this.videoLink,
    this.thumbnailLink, {
    this.postId = '',
    this.height = 170,
    this.onPostVideoTapped,
    this.showWatermark = false,
  }) : _selectedVideo = null;

  LiveFeedVideoControl.selectedVideo(
    SelectedMediaFile selectedVideo, {
    this.height = 170,
    this.showWatermark = false,
  })  : active = true,
        this.videoLink = null,
        this.thumbnailLink = null,
        this.postId = null,
        this.onPostVideoTapped = null,
        _selectedVideo = selectedVideo;

  Widget _buildContent(BuildContext context) {
    if (active) {
      return _LivefeedVideoPlayer(
        playerKey: postId == null || postId == ''
            ? 'post_video_link_$videoLink'
            : 'post_video_id_$postId',
        videoLink: videoLink,
        thumbnailLink: thumbnailLink,
        selectedVideo: _selectedVideo,
        height: height,
        showWatermark: showWatermark,
      );
    } else {
      return GestureDetector(
        onTap: () => onPostVideoTapped(postId),
        child: Stack(
          children: [
            Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(thumbnailLink),
                ),
              ),
              child: Icon(
                Icons.play_arrow,
                color: LiveFeedTheme.theme.accentColor,
                size: MediaQuery.of(context).size.width / 5,
              ),
            ),
            if (showWatermark)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                child: _WaterMark(),
              ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }
}

class _WaterMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.3,
              child: Container(
                height: 46,
                width: 133,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image(
                    image: AssetImage('assets/images/livefeed_logo.png'),
                  ),
                ),
              ),
            ),
            Text(
              state.user.id,
              style: TextStyle(color: Colors.black.withOpacity(0.3)),
            ),
          ],
        );
      },
    );
  }
}

class _LivefeedVideoPlayer extends StatefulWidget {
  _LivefeedVideoPlayer({
    this.playerKey,
    this.videoLink,
    this.thumbnailLink,
    this.selectedVideo,
    this.height = 170,
    this.showWatermark = false,
  });

  final String playerKey;
  final String videoLink;
  final String thumbnailLink;
  final SelectedMediaFile selectedVideo;
  final double height;
  final bool showWatermark;

  @override
  State<StatefulWidget> createState() => _LivefeedVideoPlayerState(
        playerKey: playerKey,
        videoLink: videoLink,
        thumbnailLink: thumbnailLink,
        selectedVideo: selectedVideo,
        height: height,
        showWatermark: showWatermark,
      );
}

class _LivefeedVideoPlayerState extends State<_LivefeedVideoPlayer> {
  _LivefeedVideoPlayerState({
    this.playerKey,
    this.videoLink,
    this.thumbnailLink,
    this.selectedVideo,
    this.height = 170,
    this.showWatermark = false,
  });

  final String playerKey;
  final String videoLink;
  final String thumbnailLink;
  final SelectedMediaFile selectedVideo;
  final double height;
  final bool showWatermark;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  bool _manuallyPaused = false;

  VisibilityDetectorController _visController = VisibilityDetectorController();

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = selectedVideo == null
        ? VideoPlayerController.network(videoLink)
        : VideoPlayerController.file(selectedVideo.file);
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      allowPlaybackSpeedChanging: false,
      allowMuting: true,
      customControls: MaterialControls(
        onManualPlayPause: () {
          setState(() {
            if (!_chewieController.isPlaying) {
              _manuallyPaused = true;
            } else {
              _manuallyPaused = false;
            }
          });
        },
        showWatermark: showWatermark,
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {
    _visController.forget(Key(playerKey));
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Widget _buildVideoView() {
    return Stack(
      children: [
        VisibilityDetector(
          key: Key(playerKey),
          onVisibilityChanged: (visibilityInfo) {
            var visiblePercentage = visibilityInfo.visibleFraction * 100;
            // debugPrint(
            //     'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
            if (visiblePercentage < 50.0) {
              _chewieController.pause();
            } else if (visiblePercentage > 50.0 &&
                !_chewieController.isPlaying &&
                !_manuallyPaused) {
              _chewieController.play();
            }
          },
          child: Container(
            height: height,
            width: double.infinity,
            color: Colors.black,
            child: Chewie(controller: _chewieController),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingView() {
    final Widget content = Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.contain,
          image: selectedVideo == null
              ? AssetImage(thumbnailLink)
              : MemoryImage(selectedVideo.videoThumbnail),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            'Loading',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (showWatermark) {
      return Stack(
        children: [
          content,
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: _WaterMark(),
          ),
        ],
      );
    } else {
      return content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController.videoPlayerController.value.isInitialized
        ? _buildVideoView()
        : _buildLoadingView();
  }
}

class MaterialControls extends StatefulWidget {
  const MaterialControls({
    Key key,
    this.onManualPlayPause,
    this.showWatermark = false,
  }) : super(key: key);
  final Function onManualPlayPause;
  final bool showWatermark;

  @override
  State<StatefulWidget> createState() {
    return _MaterialControlsState(
      onManualPlayPause: onManualPlayPause,
      showWatermark: showWatermark,
    );
  }
}

class _MaterialControlsState extends State<MaterialControls>
    with SingleTickerProviderStateMixin {
  _MaterialControlsState({
    this.onManualPlayPause,
    this.showWatermark = false,
  });

  VideoPlayerValue _latestValue;
  double _latestVolume;
  bool _hideStuff = true;
  Timer _hideTimer;
  Timer _initTimer;
  Timer _showAfterExpandCollapseTimer;
  bool _dragging = false;
  bool _displayTapped = false;

  final barHeight = 48.0;
  final marginSize = 5.0;
  final bool showWatermark;
  final Function onManualPlayPause;

  VideoPlayerController controller;
  ChewieController chewieController;
  AnimationController playPauseIconAnimationController;

  @override
  Widget build(BuildContext context) {
    if (_latestValue.hasError) {
      return chewieController.errorBuilder != null
          ? chewieController.errorBuilder(
              context,
              chewieController.videoPlayerController.value.errorDescription,
            )
          : const Center(
              child: Icon(
                Icons.error,
                color: Colors.white,
                size: 42,
              ),
            );
    }

    return MouseRegion(
      onHover: (_) {
        _cancelAndRestartTimer();
      },
      child: GestureDetector(
        onTap: () => _cancelAndRestartTimer(),
        child: AbsorbPointer(
          absorbing: _hideStuff,
          child: Column(
            children: <Widget>[
              if (_latestValue != null &&
                      !_latestValue.isPlaying &&
                      _latestValue.duration == null ||
                  _latestValue.isBuffering)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                _buildHitArea(),
              _buildBottomBar(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    controller.removeListener(_updateState);
    _hideTimer?.cancel();
    _initTimer?.cancel();
    _showAfterExpandCollapseTimer?.cancel();
  }

  @override
  void didChangeDependencies() {
    final _oldController = chewieController;
    chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;

    playPauseIconAnimationController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );

    if (_oldController != chewieController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  AnimatedOpacity _buildBottomBar(
    BuildContext context,
  ) {
    final iconColor = Theme.of(context).textTheme.button.color;

    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        height: barHeight,
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            _buildPlayPause(controller),
            if (chewieController.allowMuting) _buildMuteButton(controller),
            if (chewieController.isLive)
              const Expanded(child: Text('LIVE'))
            else
              _buildCurrentPosition(iconColor),
            if (chewieController.isLive)
              const SizedBox()
            else
              _buildProgressBar(),
            if (!chewieController.isLive) _buildTotalDuration(iconColor),
            _buildSettingsButton(),
            if (chewieController.allowPlaybackSpeedChanging)
              _buildSpeedButton(controller),
            if (chewieController.allowFullScreen) _buildExpandButton(),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildExpandButton() {
    return GestureDetector(
      onTap: _onExpandCollapse,
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: barHeight,
          margin: const EdgeInsets.only(right: 12.0),
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: Center(
            child: Icon(
              chewieController.isFullScreen
                  ? Icons.fullscreen_exit
                  : Icons.fullscreen,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSettingsButton() {
    return GestureDetector(
      onTap: _onExpandCollapse,
      child: Stack(
        children: [
          Container(
            height: barHeight,
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 2.0,
            ),
            child: Center(
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(width: 1.0, color: Colors.grey[400]),
                color: Colors.red,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                child: Text(
                  'AUTO',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildHitArea() {
    final bool isFinished = _latestValue.position >= _latestValue.duration;

    final Widget graphicsContainer = Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      child: Center(
        child: AnimatedOpacity(
          opacity: _latestValue != null && !_latestValue.isPlaying && !_dragging
              ? 1.0
              : 0.0,
          duration: const Duration(milliseconds: 300),
          child: IconButton(
            iconSize: 90,
            icon: isFinished
                ? Icon(
                    Icons.replay,
                    // size: 90.0,
                    color: LiveFeedTheme.theme.accentColor,
                  )
                : AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: playPauseIconAnimationController,
                    // size: 90.0,
                    color: LiveFeedTheme.theme.accentColor,
                  ),
            onPressed: null,
          ),
        ),
      ),
    );

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_latestValue != null && _latestValue.isPlaying) {
            if (_displayTapped) {
              setState(() {
                _hideStuff = true;
              });
            } else {
              _cancelAndRestartTimer();
            }
          } else {
            _playPause();

            setState(() {
              _hideStuff = true;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: GestureDetector(
            onTap: () {
              _playPause();
            },
            child: showWatermark
                ? Stack(
                    children: [
                      graphicsContainer,
                      Positioned(
                        child: _WaterMark(),
                      ),
                    ],
                  )
                : graphicsContainer,
          ),
        ),
      ),
    );
  }

  Widget _buildSpeedButton(
    VideoPlayerController controller,
  ) {
    return GestureDetector(
      onTap: () async {
        _hideTimer?.cancel();

        final chosenSpeed = await showModalBottomSheet<double>(
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          builder: (context) => _PlaybackSpeedDialog(
            speeds: chewieController.playbackSpeeds,
            selected: _latestValue.playbackSpeed,
          ),
        );

        if (chosenSpeed != null) {
          controller.setPlaybackSpeed(chosenSpeed);
        }

        if (_latestValue.isPlaying) {
          _startHideTimer();
        }
      },
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: ClipRect(
          child: Container(
            height: barHeight,
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: const Icon(Icons.speed),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildMuteButton(
    VideoPlayerController controller,
  ) {
    return GestureDetector(
      onTap: () {
        _cancelAndRestartTimer();

        if (_latestValue.volume == 0) {
          controller.setVolume(_latestVolume ?? 0.5);
        } else {
          _latestVolume = controller.value.volume;
          controller.setVolume(0.0);
        }
      },
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: ClipRect(
          child: Container(
            height: barHeight,
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Icon(
              (_latestValue != null && _latestValue.volume > 0)
                  ? Icons.volume_up
                  : Icons.volume_off,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildPlayPause(VideoPlayerController controller) {
    return GestureDetector(
      onTap: _playPause,
      child: Container(
        height: barHeight,
        color: Colors.transparent,
        margin: const EdgeInsets.only(left: 8.0, right: 4.0),
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 3.0,
        ),
        child: Icon(
          controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCurrentPosition(Color iconColor) {
    final position = _latestValue != null && _latestValue.position != null
        ? _latestValue.position
        : Duration.zero;
    final duration = _latestValue != null && _latestValue.duration != null
        ? _latestValue.duration
        : Duration.zero;

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Text(
        '${formatDuration(position)}',
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Widget _buildTotalDuration(Color iconColor) {
    final position = _latestValue != null && _latestValue.position != null
        ? _latestValue.position
        : Duration.zero;
    final duration = _latestValue != null && _latestValue.duration != null
        ? _latestValue.duration
        : Duration.zero;

    return Padding(
      padding: const EdgeInsets.only(),
      child: Text(
        '${formatDuration(duration)}',
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _startHideTimer();

    setState(() {
      _hideStuff = false;
      _displayTapped = true;
    });
  }

  Future<void> _initialize() async {
    controller.addListener(_updateState);

    _updateState();

    if ((controller.value != null && controller.value.isPlaying) ||
        chewieController.autoPlay) {
      _startHideTimer();
    }

    if (chewieController.showControlsOnInitialize) {
      _initTimer = Timer(const Duration(milliseconds: 200), () {
        setState(() {
          _hideStuff = false;
        });
      });
    }
  }

  void _onExpandCollapse() {
    setState(() {
      _hideStuff = true;

      chewieController.toggleFullScreen();
      _showAfterExpandCollapseTimer =
          Timer(const Duration(milliseconds: 300), () {
        setState(() {
          _cancelAndRestartTimer();
        });
      });
    });
  }

  void _playPause() {
    bool isFinished;
    if (_latestValue.duration != null) {
      isFinished = _latestValue.position >= _latestValue.duration;
    } else {
      isFinished = false;
    }

    setState(() {
      if (controller.value.isPlaying) {
        playPauseIconAnimationController.reverse();
        _hideStuff = false;
        _hideTimer?.cancel();
        controller.pause();
      } else {
        _cancelAndRestartTimer();

        if (!controller.value.isInitialized) {
          controller.initialize().then((_) {
            controller.play();
            playPauseIconAnimationController.forward();
          });
        } else {
          if (isFinished) {
            controller.seekTo(const Duration());
          }
          playPauseIconAnimationController.forward();
          controller.play();
        }
      }
    });

    onManualPlayPause();
  }

  void _startHideTimer() {
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void _updateState() {
    setState(() {
      _latestValue = controller.value;
    });
  }

  Widget _buildProgressBar() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: MaterialVideoProgressBar(
          controller,
          onDragStart: () {
            setState(() {
              _dragging = true;
            });

            _hideTimer?.cancel();
          },
          onDragEnd: () {
            setState(() {
              _dragging = false;
            });

            _startHideTimer();
          },
          colors: chewieController.materialProgressColors ??
              ChewieProgressColors(
                playedColor: Colors.red[700],
                handleColor: Colors.white,
                bufferedColor: Colors.transparent,
                backgroundColor: Colors.transparent,
              ),
        ),
      ),
    );
  }
}

class _PlaybackSpeedDialog extends StatelessWidget {
  const _PlaybackSpeedDialog({
    Key key,
    @required List<double> speeds,
    @required double selected,
  })  : _speeds = speeds,
        _selected = selected,
        super(key: key);

  final List<double> _speeds;
  final double _selected;

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = Theme.of(context).primaryColor;

    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        final _speed = _speeds[index];
        return ListTile(
          dense: true,
          title: Row(
            children: [
              if (_speed == _selected)
                Icon(
                  Icons.check,
                  size: 20.0,
                  color: selectedColor,
                )
              else
                Container(width: 20.0),
              const SizedBox(width: 16.0),
              Text(_speed.toString()),
            ],
          ),
          selected: _speed == _selected,
          onTap: () {
            Navigator.of(context).pop(_speed);
          },
        );
      },
      itemCount: _speeds.length,
    );
  }
}

class MaterialVideoProgressBar extends StatefulWidget {
  MaterialVideoProgressBar(
    this.controller, {
    ChewieProgressColors colors,
    this.onDragEnd,
    this.onDragStart,
    this.onDragUpdate,
    Key key,
  })  : colors = colors ?? ChewieProgressColors(),
        super(key: key);

  final VideoPlayerController controller;
  final ChewieProgressColors colors;
  final Function() onDragStart;
  final Function() onDragEnd;
  final Function() onDragUpdate;

  @override
  _VideoProgressBarState createState() {
    return _VideoProgressBarState();
  }
}

class _VideoProgressBarState extends State<MaterialVideoProgressBar> {
  _VideoProgressBarState() {
    listener = () {
      if (!mounted) return;
      setState(() {});
    };
  }

  VoidCallback listener;
  bool _controllerWasPlaying = false;

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    void seekToRelativePosition(Offset globalPosition) {
      final box = context.findRenderObject() as RenderBox;
      final Offset tapPos = box.globalToLocal(globalPosition);
      final double relative = tapPos.dx / box.size.width;
      final Duration position = controller.value.duration * relative;
      controller.seekTo(position);
    }

    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        if (!controller.value.isInitialized) {
          return;
        }
        _controllerWasPlaying = controller.value.isPlaying;
        if (_controllerWasPlaying) {
          controller.pause();
        }

        if (widget.onDragStart != null) {
          widget.onDragStart();
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!controller.value.isInitialized) {
          return;
        }
        seekToRelativePosition(details.globalPosition);

        if (widget.onDragUpdate != null) {
          widget.onDragUpdate();
        }
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_controllerWasPlaying) {
          controller.play();
        }

        if (widget.onDragEnd != null) {
          widget.onDragEnd();
        }
      },
      onTapDown: (TapDownDetails details) {
        if (!controller.value.isInitialized) {
          return;
        }
        seekToRelativePosition(details.globalPosition);
      },
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: CustomPaint(
            painter: _ProgressBarPainter(
              controller.value,
              widget.colors,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressBarPainter extends CustomPainter {
  _ProgressBarPainter(this.value, this.colors)
      : smallHandlePaint = Paint()..color = Colors.black;

  VideoPlayerValue value;
  ChewieProgressColors colors;
  final Paint smallHandlePaint;

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const height = 12.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2),
          Offset(size.width, size.height / 2 + height),
        ),
        const Radius.circular(4.0),
      ),
      colors.backgroundPaint,
    );
    if (!value.isInitialized) {
      return;
    }
    final double playedPartPercent =
        value.position.inMilliseconds / value.duration.inMilliseconds;
    final double playedPart =
        playedPartPercent > 1 ? size.width : playedPartPercent * size.width;
    for (final DurationRange range in value.buffered) {
      final double start = range.startFraction(value.duration) * size.width;
      final double end = range.endFraction(value.duration) * size.width;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(
            Offset(start, size.height / 2),
            Offset(end, size.height / 2 + height),
          ),
          const Radius.circular(4.0),
        ),
        colors.bufferedPaint,
      );
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2.5),
          Offset(playedPart, size.height / 2.5 + height),
        ),
        const Radius.circular(4.0),
      ),
      colors.playedPaint,
    );
    var outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2.5),
          Offset(size.width, size.height / 2.5 + height),
        ),
        const Radius.circular(4.0),
      ),
      outlinePaint,
    );
    canvas.drawCircle(
      Offset(playedPart, size.height / 2.5 + height / 2),
      height * 0.9,
      colors.handlePaint,
    );
    canvas.drawCircle(
      Offset(playedPart, size.height / 2.5 + height / 2),
      height * 0.35,
      smallHandlePaint,
    );
  }
}

String formatDuration(Duration position) {
  final ms = position.inMilliseconds;

  int seconds = ms ~/ 1000;
  final int hours = seconds ~/ 3600;
  seconds = seconds % 3600;
  final minutes = seconds ~/ 60;
  seconds = seconds % 60;

  final hoursString = hours >= 10
      ? '$hours'
      : hours == 0
          ? '00'
          : '0$hours';

  final minutesString = minutes >= 10
      ? '$minutes'
      : minutes == 0
          ? '00'
          : '0$minutes';

  final secondsString = seconds >= 10
      ? '$seconds'
      : seconds == 0
          ? '00'
          : '0$seconds';

  final formattedTime =
      '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';

  return formattedTime;
}
