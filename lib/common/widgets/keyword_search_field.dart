import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';

class KeywordSearchField extends StatefulWidget {
  KeywordSearchField({this.onChanged});

  final Function(String value, bool filtered) onChanged;

  @override
  State<StatefulWidget> createState() => KeywordSearchFieldState(
        onChanged: onChanged,
      );
}

class KeywordSearchFieldState extends State<KeywordSearchField> {
  KeywordSearchFieldState({this.onChanged});

  bool filtered = false;
  String keyword = '';
  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = new FocusNode();
  final Function(String value, bool filtered) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      onChanged: (value) {
        setState(() {
          keyword = value;
        });
        if (onChanged != null) {
          onChanged(keyword, filtered);
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 20,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 14),
          child: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        hintText: 'Search by keyword',
        hintStyle: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          fontSize: 15,
          color: Colors.grey,
        ),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        suffix: Wrap(
          spacing: 12,
          children: [
            GestureDetector(
              onTap: keyword.length > 0
                  ? () {
                      setState(() {
                        filtered = true;
                        _focusNode.unfocus();
                      });
                      onChanged(keyword, filtered);
                    }
                  : null,
              child: Text(
                'Search',
                style: TextStyle(
                  color: keyword.length > 0
                      ? LiveFeedTheme.theme.highlightColor
                      : Colors.grey,
                ),
              ),
            ),
            if (filtered)
              GestureDetector(
                onTap: () {
                  setState(() {
                    filtered = false;
                    keyword = '';
                    _textController.text = '';
                    Future.delayed(Duration(microseconds: 10), () {
                      _focusNode.unfocus();
                    });
                    onChanged(keyword, filtered);
                  });
                },
                child: Text(
                  'Clear',
                  style: TextStyle(color: LiveFeedTheme.theme.highlightColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
