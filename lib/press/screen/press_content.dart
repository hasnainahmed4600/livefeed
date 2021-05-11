import 'package:flutter/material.dart';
import 'package:livefeed/common/widgets/video_player.dart';
import 'package:livefeed/press/bloc/press_list_bloc.dart';
import 'package:livefeed/theme.dart';
import 'package:intl/intl.dart';
import 'package:livefeed/press/models/press_item_vm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PressContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PressContentState();
}

class _PressContentState extends State<PressContent> {
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      context.read<PressListBloc>().add(EndOfListReached());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PressListBloc, PressListState>(
      builder: (context, state) {
        var toRenderItems = <Widget>[];

        state.pressItems.forEach((pressItemVm) {
          toRenderItems.add(_PressListItem(pressItemVm));
          toRenderItems.add(const Padding(padding: EdgeInsets.only(top: 10)));
        });

        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 10)),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: RichText(
                  text: TextSpan(
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'For media inquiries, ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'contact us',
                        style: TextStyle(
                          color: LiveFeedTheme.theme.highlightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' here',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              ...toRenderItems,
            ],
          ),
        );
      },
    );
  }
}

class _PressListItem extends StatefulWidget {
  final PressItemVm pressItem;

  _PressListItem(this.pressItem);
  @override
  State<StatefulWidget> createState() => _PressListItemState(pressItem);
}

class _PressListItemState extends State<_PressListItem> {
  bool _expanded = false;
  final PressItemVm pressItem;

  _PressListItemState(
    this.pressItem,
  );

  Widget _buildContent() {
    print('Content rendered: ${pressItem.id}');
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: BlocBuilder<PressListBloc, PressListState>(
        builder: (context, state) {
          return Column(
            children: [
              pressItem.hasVideo
                  ? LiveFeedVideoControl(
                      pressItem.id == state.activeVideoItemId,
                      pressItem.videoUrl,
                      pressItem.imagePath,
                      postId: pressItem.id,
                      onPostVideoTapped: (id) {
                        context
                            .read<PressListBloc>()
                            .add(VideoPlayed(pressItem.id));
                      },
                      height: 150,
                    )
                  : Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: pressItem.networkImage
                              ? NetworkImage(pressItem.imagePath)
                              : AssetImage(pressItem.imagePath),
                        ),
                      ),
                    ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                pressItem.content,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContentSlug() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: RichText(
        text: TextSpan(
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          children: <TextSpan>[
            TextSpan(
              text: pressItem.content.substring(0, 85),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: ' Read more...',
              style: TextStyle(
                color: LiveFeedTheme.theme.highlightColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedHeader() {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 10,
      ),
      title: Text(
        pressItem.title,
        style: TextStyle(
          fontWeight: FontWeight.w900,
        ),
      ),
      subtitle: Text(
        '${DateFormat.jm().format(pressItem.postDate)} | ${DateFormat.d().format(pressItem.postDate)} ${DateFormat.MMMM().format(pressItem.postDate)} ${DateFormat.y().format(pressItem.postDate)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      trailing: FlatButton(
        minWidth: 5,
        height: 2,
        onPressed: () {
          context.read<PressListBloc>().add(VideoCleared(pressItem.id));
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
    );
  }

  Widget _buildCollapsedHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 4,
            left: 6,
          ),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: pressItem.networkImage
                    ? NetworkImage(pressItem.imagePath)
                    : AssetImage(pressItem.imagePath),
              ),
            ),
            child: pressItem.hasVideo
                ? Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 40,
                  )
                : null,
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            visualDensity: VisualDensity.standard,
            title: Text(
              pressItem.title,
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
            subtitle: Text(
              '${DateFormat.jm().format(pressItem.postDate)} | ${DateFormat.d().format(pressItem.postDate)} ${DateFormat.MMMM().format(pressItem.postDate)} ${DateFormat.y().format(pressItem.postDate)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
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
            _expanded ? _buildExpandedHeader() : _buildCollapsedHeader(),
            _expanded ? _buildContent() : _buildContentSlug(),
          ],
        ),
      ),
    );
  }
}
