import 'package:flutter/material.dart';
import 'package:livefeed/common/widgets/interest_search_filter.dart';
import 'package:livefeed/common/widgets/keyword_search_field.dart';
import 'package:livefeed/theme.dart';
import 'package:sortedmap/sortedmap.dart';

class ContentSearchInput extends StatelessWidget {
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
      child: Column(
        children: [
          KeywordSearchField(),
          const Padding(padding: EdgeInsets.only(top: 10)),
          // _SearchFiltersMenu(),
          InterestSearchFilter(
            onChanged: (values) {
              print(values);
            },
          ),
        ],
      ),
    );
  }
}

class _InterestList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InterestListState();
}

class _InterestListState extends State<_InterestList> {
  Map<String, bool> interestsFilter = Map<String, bool>();

  @override
  void initState() {
    interestsFilter.addAll({
      'Auto': false,
      'Crime': false,
      'Events': false,
      'Entertainment': false,
      'Finance': false,
      'Food': false,
      'Health': false,
      'Master Class': false,
      'Moto': false,
      'Pets': false,
      'Politics': false,
      'Positive': false,
      'Protest': false,
      'Science': false,
      'Sports': false,
      'Tech': false,
      'Travel': false,
      'Weather': false,
    });
    super.initState();
  }

  void _toggleInterest(String interest) {
    if (interestsFilter[interest] == true) {
      setState(() {
        interestsFilter.update(interest, (value) => !value);
      });
      return;
    }
    if (interestsFilter.values
            .where((interestValue) => interestValue == true)
            .length <
        3) {
      setState(() {
        interestsFilter.update(interest, (value) => !value);
      });
    }
  }

  void _clearInterests() {
    setState(() {
      interestsFilter = new SortedMap(Ordering.byKey());
      interestsFilter.addAll({
        'Auto': false,
        'Crime': false,
        'Events': false,
        'Entertainment': false,
        'Finance': false,
        'Food': false,
        'Health': false,
        'Master Class': false,
        'Moto': false,
        'Pets': false,
        'Politics': false,
        'Positive': false,
        'Protest': false,
        'Science': false,
        'Sports': false,
        'Tech': false,
        'Travel': false,
        'Weather': false,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var interestLabels = <_InterestLabel>[];
    interestsFilter.forEach((key, value) {
      interestLabels.add(_InterestLabel(
        key,
        value,
        onToggled: (value) => _toggleInterest(value),
      ));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 35,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 10),
            children: [
              ...interestLabels,
            ],
          ),
        ),
        interestsFilter.values.any((value) => value == true)
            ? Padding(
                padding: EdgeInsets.only(top: 10),
                child: Wrap(
                  spacing: 5,
                  children: [
                    Text(
                      '${interestsFilter.values.where((element) => element == true).length} categories selected',
                    ),
                    GestureDetector(
                      onTap: () => _clearInterests(),
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: LiveFeedTheme.theme.highlightColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('Select up to 3 categories'),
              ),
      ],
    );
  }
}

class _InterestLabel extends StatelessWidget {
  final String interestName;
  final bool enabled;
  final Function(String value) onToggled;
  _InterestLabel(
    this.interestName,
    this.enabled, {
    this.onToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () => this.onToggled(interestName),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: enabled ? Color.fromRGBO(170, 59, 241, 1) : Colors.grey[300],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: Text(
              interestName.toUpperCase(),
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                color: enabled ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
