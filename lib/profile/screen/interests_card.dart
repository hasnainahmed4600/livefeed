import 'dart:math';

import 'package:flutter/material.dart';
import 'package:livefeed/common/models/location_vm.dart';
import 'package:livefeed/common/widgets/ensure_visible.dart';
import 'package:livefeed/common/widgets/location_search_control.dart';
import 'package:livefeed/theme.dart';

class InterestCard extends StatefulWidget {
  InterestCard({
    this.onInterestSearchFocused,
  });

  final Function onInterestSearchFocused;

  @override
  State<StatefulWidget> createState() => _InterestsCardState(
        onInterestSearchFocused: onInterestSearchFocused,
      );
}

class _InterestsCardState extends State<InterestCard> {
  _InterestsCardState({this.onInterestSearchFocused});

  bool expanded = false;
  List<String> availableInterests = <String>[
    'Events',
    'Entertainment',
    'Weather',
    'Politics',
    'Crime',
    'Pets',
    'Protest',
    'Positive',
    'Food',
    'Health',
    'Tech',
    'Auto',
    'Moto',
    'Finance',
    'Sports',
    'Travel',
    'Science',
    'Master Class',
  ];
  List<String> selectedInterests = <String>[];
  List<LocationVm> selectedLocations = <LocationVm>[];
  final Function onInterestSearchFocused;

  void addLocation(String address, String zipCode) {
    if (!selectedLocations.any((location) =>
            location.address == address && location.zipCode == zipCode) &&
        selectedLocations.length < 3) {
      setState(() {
        selectedLocations.add(LocationVm(address: address, zipCode: zipCode));
      });
    }
  }

  void removeLocation(String id) {
    setState(() {
      selectedLocations.removeWhere((location) => location.id == id);
    });
  }

  Widget buildLocationsList() {
    final listItems = selectedLocations
        .map(
          (location) => ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              '${location.address} ${location.zipCode}',
            ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => removeLocation(location.id),
            ),
          ),
        )
        .toList();
    return Column(
      children: listItems,
    );
  }

  Widget _buildLocationsIndicator() {
    if (selectedLocations.length <= 0) {
      return Text('Select up to 3 locations');
    } else {
      return Text('${selectedLocations.length}/3 locations selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CardHeader(
              () {
                setState(() {
                  this.expanded = !this.expanded;
                });
              },
              this.expanded,
            ),
            Divider(
              thickness: 2,
              height: 0,
            ),
            _InterestDetails(
              availableInterests,
              selectedInterests,
              (newAvailableInterests) {
                setState(() {
                  availableInterests = newAvailableInterests;
                });
              },
              (newSelectedInterests) {
                setState(() {
                  selectedInterests = newSelectedInterests;
                });
              },
              onInterestSearchFocused: onInterestSearchFocused,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(width: 1.0, color: Colors.grey[500]),
                  color: Color.fromRGBO(247, 248, 249, 1),
                ),
                child: LocationSearchControl(
                  hintText: 'Interests by location',
                  onAddressUpdated: (address, zipCode) =>
                      addLocation(address, zipCode),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _buildLocationsIndicator(),
            ),
            if (selectedLocations.length > 0) buildLocationsList(),
            const Padding(padding: EdgeInsets.only(top: 15)),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _CardHeader(
              () {
                setState(() {
                  this.expanded = !this.expanded;
                });
              },
              this.expanded,
            )
          ],
        ),
      );
    }
  }
}

class _CardHeader extends StatelessWidget {
  final Function onTap;
  final bool expanded;

  _CardHeader(this.onTap, this.expanded);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(
        'MY INTERESTS',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Transform.rotate(
        angle: expanded ? pi / 2 : pi / -2,
        alignment: Alignment.center,
        child: Icon(
          Icons.chevron_left,
          color: LiveFeedTheme.theme.highlightColor,
          size: 32,
        ),
      ),
      onTap: this.onTap,
    );
  }
}

class _InterestDetails extends StatefulWidget {
  final List<String> initialAvailableInterests;
  final List<String> initialSelectedInterests;
  final Function(List<String>) onAvailableInterestsUpdated;
  final Function(List<String>) onSelectedInterestsUpdated;
  final Function onInterestSearchFocused;

  _InterestDetails(
    this.initialAvailableInterests,
    this.initialSelectedInterests,
    this.onAvailableInterestsUpdated,
    this.onSelectedInterestsUpdated, {
    this.onInterestSearchFocused,
  });

  @override
  State<StatefulWidget> createState() => _InterestDetailsState(
        initialAvailableInterests,
        initialSelectedInterests,
        onAvailableInterestsUpdated,
        onSelectedInterestsUpdated,
        onInterestSearchFocused: onInterestSearchFocused,
      );
}

class _InterestDetailsState extends State<_InterestDetails> {
  _InterestDetailsState(
    this.initialAvailableInterests,
    this.initialSelectedInterests,
    this.onAvailableInterestsUpdated,
    this.onSelectedInterestsUpdated, {
    this.onInterestSearchFocused,
  });

  bool _searching = false;
  TextEditingController _textController = TextEditingController();
  FocusNode _searchFocusNode = new FocusNode();
  bool _searchSelected = false;

  final Function(List<String>) onAvailableInterestsUpdated;
  final Function(List<String>) onSelectedInterestsUpdated;
  final Function onInterestSearchFocused;
  final List<String> initialAvailableInterests;
  final List<String> initialSelectedInterests;
  List<String> _currentAvailableInterests = <String>[];

  List<String> searchedInterests = <String>[];
  List<String> _currentSelectedInterests = <String>[];

  void performSearch(String queryString) {
    if (queryString.length > 0) {
      setState(() {
        _searching = true;
        searchedInterests = _currentAvailableInterests
            .where((interest) =>
                interest.toLowerCase().contains(queryString.toLowerCase()) &&
                !_currentSelectedInterests
                    .any((selectedInterest) => selectedInterest == interest))
            .toList();
      });
    } else {
      setState(() {
        _searching = false;
        searchedInterests = <String>[];
      });
    }
  }

  void addInterest(String newInterest) {
    if (!_currentSelectedInterests.any((interest) => interest == newInterest) &&
        _currentSelectedInterests.length < 3) {
      setState(() {
        _currentSelectedInterests.add(newInterest);
        searchedInterests.remove(newInterest);
        _currentAvailableInterests.remove(newInterest);
        _searching = false;

        _currentAvailableInterests.sort();
        searchedInterests.sort();
        _textController.text = '';
        onAvailableInterestsUpdated(_currentAvailableInterests);
        onSelectedInterestsUpdated(_currentSelectedInterests);
      });
    }
  }

  void removeInterest(String toRemoveInterest) {
    setState(() {
      _currentSelectedInterests.remove(toRemoveInterest);
      _currentAvailableInterests.add(toRemoveInterest);
      _currentAvailableInterests.sort();
      onAvailableInterestsUpdated(_currentAvailableInterests);
      onSelectedInterestsUpdated(_currentSelectedInterests);
    });
  }

  @override
  void initState() {
    _currentAvailableInterests = initialAvailableInterests;
    _currentSelectedInterests = initialSelectedInterests;
    _currentAvailableInterests.sort();
    searchedInterests.sort();
    _searchFocusNode.addListener(_onFocusChanged);
    super.initState();
  }

  void _onFocusChanged() {
    print('onFocusChanged');
    setState(() {
      if (_searchFocusNode.hasFocus) {
        _searchSelected = true;
        // onInterestSearchFocused();
      } else {
        _searchSelected = false;
      }
    });
  }

  Widget _buildInterestIndicator() {
    if (_currentSelectedInterests.length <= 0) {
      return Text('Select up to 3 interests');
    } else {
      return Text(
        '${_currentSelectedInterests.length}/3 interests selected',
        textAlign: TextAlign.left,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget interestInput = EnsureVisibleWhenFocused(
      child: _AddInterestInput(
        _textController,
        _searchFocusNode,
        onChanged: (value) {
          performSearch(value);
        },
      ),
      focusNode: _searchFocusNode,
    );
    Widget interestList = _InterestList(
      _currentSelectedInterests,
      (value) {
        removeInterest(value);
      },
    );
    if (_searchSelected) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(padding: EdgeInsets.only(top: 18)),
            interestInput,
            const Padding(padding: EdgeInsets.only(top: 5)),
            _buildInterestIndicator(),
            const Padding(padding: EdgeInsets.only(top: 10)),
            interestList,
            const Padding(padding: EdgeInsets.only(top: 10)),
            _SearchResultList(
              _searching ? searchedInterests : _currentAvailableInterests,
              (value) {
                addInterest(value);
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(padding: EdgeInsets.only(top: 18)),
            interestInput,
            const Padding(padding: EdgeInsets.only(top: 5)),
            _buildInterestIndicator(),
            const Padding(padding: EdgeInsets.only(top: 10)),
            interestList,
            const Padding(padding: EdgeInsets.only(top: 5)),
          ],
        ),
      );
    }
  }
}

class _AddInterestInput extends StatelessWidget {
  final Function(String value) onChanged;
  final TextEditingController _textController;
  final FocusNode focus;

  _AddInterestInput(
    this._textController,
    this.focus, {
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LiveFeedTheme.theme.copyWith(
        primaryColor: Colors.grey,
        inputDecorationTheme: LiveFeedTheme.theme.inputDecorationTheme.copyWith(
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            height: 1.55,
            fontSize: 14,
          ),
        ),
      ),
      child: TextField(
        onChanged: (value) => this.onChanged(value),
        controller: _textController,
        focusNode: focus,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 20,
          ),
          suffixIcon: focus.hasFocus
              ? GestureDetector(
                  onTap: () => focus.unfocus(),
                  child: Icon(Icons.close),
                )
              : null,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 26, right: 14),
            child: Icon(Icons.search),
          ),
          hintText: 'Add Interest',
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

class _SearchResultList extends StatelessWidget {
  final List<String> results;
  final Function(String value) onInterestSelected;

  _SearchResultList(this.results, this.onInterestSelected);

  @override
  Widget build(BuildContext context) {
    if (results.length > 0) {
      var mainColumn = Column(
        children: [],
      );
      results.forEach(
        (result) {
          mainColumn.children.add(
            ListTile(
              title: Text(result),
              onTap: () => onInterestSelected(result),
            ),
          );
          mainColumn.children.add(Divider(
            height: 1,
            thickness: 1,
          ));
        },
      );
      return Container(
        width: double.infinity,
        child: mainColumn,
      );
    } else {
      return Text('No interests found');
    }
  }
}

class _InterestList extends StatelessWidget {
  final List<String> interests;
  final Function(String value) onInterestRemoved;

  _InterestList(this.interests, this.onInterestRemoved);

  @override
  Widget build(BuildContext context) {
    var interestLabels = <_InterestLabel>[];
    interests.forEach((interest) {
      interestLabels.add(_InterestLabel(
        interest,
        this.onInterestRemoved,
      ));
    });
    return Container(
      width: double.infinity,
      child: Wrap(
        runSpacing: 5,
        spacing: 5,
        direction: Axis.horizontal,
        children: interestLabels,
      ),
    );
  }
}

class _InterestLabel extends StatelessWidget {
  final String interestName;
  final Function(String value) onRemoved;

  _InterestLabel(this.interestName, this.onRemoved);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Color.fromRGBO(170, 59, 241, 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              interestName,
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            GestureDetector(
              onTap: () => this.onRemoved(interestName),
              child: Icon(
                Icons.close,
                size: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
