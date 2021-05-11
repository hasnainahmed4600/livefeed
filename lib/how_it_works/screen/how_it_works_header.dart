import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/how_it_works/bloc/how_it_works_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HowItWorksHeader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HowItWorksHeaderState();
}

class _HowItWorksHeaderState extends State<HowItWorksHeader> {
  _HowItWorksHeaderState({this.onQuestionSearched});
  final List<String> _suggestions = <String>[
    'Add post',
    'Find news',
    'Marketplace',
  ];
  final Function(String questionKey) onQuestionSearched;
  TextEditingController _questionTextController = TextEditingController();
  FocusNode _focusNode = new FocusNode();

  Map<HowItWorksQuestion, String> getSearchResults(String searchQuery) {
    if (searchQuery.length == 0) {
      return howItWorksQuestions;
    }
    var searchResults = Map<HowItWorksQuestion, String>();
    howItWorksQuestions.forEach((key, value) {
      if (value.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResults.addAll({key: value});
      }
    });
    return searchResults;
  }

  Future<void> _showSearchResults(
      BuildContext context, Map<HowItWorksQuestion, String> results) async {
    var listItems = <ListTile>[];
    if (results.length == 0) {
      listItems.add(
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'No results, try suggestions.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      );
    } else {
      results.forEach((key, value) {
        listItems.add(
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              context.read<HowItWorksBloc>().add(DisplayingQuestionsSearched(
                    _questionTextController.text,
                    [key],
                  ));
              Navigator.of(context).pop();
            },
          ),
        );
      });
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment(0, -1),
            child: Padding(
              padding: EdgeInsets.only(top: 150),
              child: Material(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    child: ListBody(
                      children: <Widget>[
                        ...listItems,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HowItWorksBloc, HowItWorksState>(
      buildWhen: (previous, current) =>
          previous.searchQuestion != current.searchQuestion,
      builder: (context, state) {
        _questionTextController.text = state.searchQuestion;
        return Container(
          // height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/earth3x.png'),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'YOU + livefeed = Zillion Audience',
                  style: LiveFeedTheme.theme.textTheme.headline1.copyWith(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _questionTextController,
                  focusNode: _focusNode,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  // onChanged: (value) {
                  //   context
                  //       .read<HowItWorksBloc>()
                  //       .add(SearchQuestionUpdated(value));
                  // },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Enter your question',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      child: FlatButton(
                        color: LiveFeedTheme.theme.accentColor,
                        minWidth: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 5,
                        ),
                        onPressed: () {
                          _focusNode.unfocus();
                          _showSearchResults(context,
                              getSearchResults(_questionTextController.text));
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: _Suggestions(_suggestions, (suggestion) {
                  _questionTextController.text = suggestion;
                  context
                      .read<HowItWorksBloc>()
                      .add(SearchQuestionUpdated(suggestion));
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Suggestions extends StatelessWidget {
  _Suggestions(this.suggestionsList, this.onSuggestionTapped);

  final List<String> suggestionsList;
  final Function(String suggestion) onSuggestionTapped;

  List<GestureDetector> _buildSuggestionLabels() {
    return suggestionsList.map((suggestion) {
      return GestureDetector(
        onTap: () => onSuggestionTapped(suggestion),
        child: _SuggestionLabel(suggestion),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggestions',
          style: TextStyle(
            color: Colors.grey[200],
            fontWeight: FontWeight.w600,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 5,
          children: [
            ..._buildSuggestionLabels(),
          ],
        ),
      ],
    );
  }
}

class _SuggestionLabel extends StatelessWidget {
  final String suggestion;
  _SuggestionLabel(this.suggestion);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.grey.withOpacity(0.7),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5,
        ),
        child: Text(
          suggestion,
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
