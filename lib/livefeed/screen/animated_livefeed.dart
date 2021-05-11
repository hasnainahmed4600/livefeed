import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/common/models/livefeed_post.dart';
import 'package:livefeed/livefeed/bloc/livefeed_bloc.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/timeline_post/screen/timeline_post_screen.dart';

class AnimatedLivefeedList extends StatefulWidget {
  AnimatedLivefeedList(this.scrollController);
  final ScrollController scrollController;
  @override
  _AnimatedLivefeedListState createState() =>
      _AnimatedLivefeedListState(scrollController);
}

class _AnimatedLivefeedListState extends State<AnimatedLivefeedList> {
  _AnimatedLivefeedListState(this.scrollController);
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<LiveFeedPost> _list;
  final ScrollController scrollController;

  // String _selectedItem;
  // String
  //     _nextItem; // The next item inserted when the user presses the '+' button.

  @override
  void initState() {
    // final postIds = context.read<LivefeedBloc>().state.posts.map((e) => e.id);

    super.initState();
    _list = ListModel<LiveFeedPost>(
      listKey: _listKey,
      initialItems: <LiveFeedPost>[],
      removedItemBuilder: _buildRemovedItem,
    );
    // _nextItem = Uuid().v4();
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return _LivefeedListItem(_list[index], animation);
  }

  // Used to build an item after it has been removed from the list. This
  // method is needed because a removed item remains visible until its
  // animation has completed (even though it's gone as far this ListModel is
  // concerned). The widget will be used by the
  // [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(
      String item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert(int index, LiveFeedPost newPost) {
    // final int index =
    //     _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, newPost);
  }

  // // Remove the selected item from the list model.
  // void _remove() {
  //   if (_selectedItem != null) {
  //     _list.removeAt(_list.indexOf(_selectedItem));
  //     setState(() {
  //       _selectedItem = null;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LivefeedBloc, LivefeedState>(
      listener: (context, state) {
        if (state.withinTopRollInThreshold &&
            state.streamedPostsQueue.length > 0) {
          state.streamedPostsQueue.forEach((post) {
            _insert(0, post);
          });
          context.read<LivefeedBloc>().add(StreamedPostsInserted());
        }
        if (state.loadedPostsQueue.length > 0) {
          state.loadedPostsQueue.forEach((post) {
            _insert(_list.length == 0 ? 0 : _list.length - 1, post);
          });
          context.read<LivefeedBloc>().add(LoadedPostsInserted());
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: AnimatedList(
          key: _listKey,
          shrinkWrap: true,
          controller: scrollController,
          initialItemCount: _list.length,
          itemBuilder: _buildItem,
        ),
      ),
    );
  }
}

/// Keeps a Dart [List] in sync with an [AnimatedLivefeedList].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that
/// mutate the list must make the same changes to the animated list in terms
/// of [AnimatedListState.insertItem] and [AnimatedLivefeedList.removeItem].
class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value.
///
/// The text is displayed in bright green if [selected] is
/// true. This widget's height is based on the [animation] parameter, it
/// varies from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected = false})
      : assert(animation != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final String item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    // print('LiveFEED item: $item');
    TextStyle textStyle = Theme.of(context).textTheme.headline4;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 80.0,
            child: Card(
              child: Center(
                child: Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LivefeedListItem extends StatelessWidget {
  _LivefeedListItem(
    this.post,
    this.animation,
  );

  final LiveFeedPost post;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final postedOn = post.postDate;
    var timeAgo = '';
    if (DateTime.now().difference(postedOn).inMinutes <= 5) {
      timeAgo = 'Just now';
    } else if (DateTime.now().difference(postedOn).inMinutes <= 59) {
      timeAgo = '${DateTime.now().difference(postedOn).inMinutes} minutes ago';
    } else if (DateTime.now().difference(postedOn).inHours < 24) {
      if (DateTime.now().difference(postedOn).inHours > 1)
        timeAgo = '${DateTime.now().difference(postedOn).inHours} hours ago';
      else
        timeAgo = '${DateTime.now().difference(postedOn).inHours} hour ago';
    } else if (DateTime.now().difference(postedOn).inHours > 24 &&
        DateTime.now().difference(postedOn).inHours < 730.001) {
      if (DateTime.now().difference(postedOn).inDays > 1)
        timeAgo = '${DateTime.now().difference(postedOn).inDays} days ago';
      else
        timeAgo = '${DateTime.now().difference(postedOn).inDays} day ago';
    } else {
      if (DateTime.now().difference(postedOn).inDays / 30 > 1)
        timeAgo =
            '${DateTime.now().difference(postedOn).inDays / 30} months ago';
      else
        timeAgo =
            '${DateTime.now().difference(postedOn).inDays / 30} month ago';
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SizeTransition(
        sizeFactor: animation,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage(
                          post.isVideoAsset
                              ? post.videoAssetThumbnailUrl
                              : post.assetPath,
                        ),
                      ),
                    ),
                    child: post.isVideoAsset
                        ? Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width / 5,
                          )
                        : null,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 10)),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    visualDensity: VisualDensity.standard,
                    title: Column(
                      // spacing: 15,
                      // runSpacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25,
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                            child: Wrap(
                              // crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                Text(
                                  post.postLocation,
                                  style: LiveFeedTheme.theme.textTheme.bodyText1
                                      .copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5)),
                        Text(
                          timeAgo,
                          style:
                              LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .push(TimelinePostScreen.route()),
                        child: RichText(
                          text: TextSpan(
                            text: post.postHeadline,
                            style: LiveFeedTheme.theme.textTheme.bodyText1
                                .copyWith(
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' See more...',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
