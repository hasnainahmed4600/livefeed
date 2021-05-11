import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:livefeed/common/blocs/post_form/post_form_bloc.dart';
import 'package:livefeed/common/widgets/location_field.dart';
import 'package:livefeed/common/widgets/media_upload_field.dart';
import 'package:livefeed/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddPostCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddPostCardState();
}

class _AddPostCardState extends State<AddPostCard> {
  String address = 'Chicago, IL';
  String zipCode = '60606';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 5,
          bottom: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeadlineInput(),
            const Padding(padding: EdgeInsets.only(top: 10)),
            _DescriptionInput(),
            const Padding(padding: EdgeInsets.only(top: 15)),
            _CategoryMenu(),
            const Padding(padding: EdgeInsets.only(top: 15)),
            // _MediaUploadContainer(),
            MediaUploadField(
              onFilePicked: (file) =>
                  context.read<PostFormBloc>().add(MediaFileAdded(file)),
              onFileDeleted: (fileId) =>
                  context.read<PostFormBloc>().add(MediaFileRemoved(fileId)),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            LocationField((newAddress, newZipCode) {
              context
                  .read<PostFormBloc>()
                  .add(LocationUpdated('$newAddress $newZipCode'));
              setState(() {
                address = newAddress;
                zipCode = newZipCode;
              });
            }),
            // _LocationControl(),
            // PostAddressControl(
            //   (newAddress, newZipCode) {
            //     setState(() {
            //       address = newAddress;
            //       zipCode = newZipCode;
            //     });
            //   },
            // ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            _SubmitControl(),
          ],
        ),
      ),
    );
  }
}

class _HeadlineInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostFormBloc, PostFormState>(
      builder: (context, state) {
        final loadedState = state as PostFormLoadSuccess;
        return TextField(
          maxLength: 80,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
            hintText: 'Headline...',
            filled: true,
            errorText: loadedState.headline.errorText(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[800],
                width: 2,
              ),
            ),
            hoverColor: Colors.grey[200],
            fillColor: Colors.white,
            focusColor: Colors.grey[200],
            hintStyle:
                LiveFeedTheme.theme.inputDecorationTheme.hintStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
          ),
          onChanged: (String value) =>
              context.read<PostFormBloc>().add(HeadlineUpdated(value)),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostFormBloc, PostFormState>(
      builder: (context, state) {
        final loadedState = state as PostFormLoadSuccess;
        return TextField(
          maxLength: 2000,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            hintText: 'Description...',
            errorText: loadedState.description.errorText(),
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[800],
                width: 2,
              ),
            ),
            hoverColor: Colors.grey[200],
            fillColor: Colors.white,
            focusColor: Colors.grey[200],
            hintStyle:
                LiveFeedTheme.theme.inputDecorationTheme.hintStyle.copyWith(
              color: Colors.grey,
            ),
          ),
          style: LiveFeedTheme.theme.textTheme.bodyText1,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          onChanged: (value) =>
              context.read<PostFormBloc>().add(DescriptionUpdated(value)),
        );
      },
    );
  }
}

class _CategoryMenu extends StatelessWidget {
  final List<String> categories = <String>[
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

  @override
  Widget build(BuildContext context) {
    categories.sort();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CATEGORY'),
        const Padding(padding: EdgeInsets.only(top: 5)),
        Container(
          width: double.infinity,
          child: DropdownButtonFormField(
            hint: Text(
              'Select',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            style: LiveFeedTheme.theme.textTheme.bodyText1
                .copyWith(fontWeight: FontWeight.w500),
            icon: Transform.rotate(
              angle: pi / -2,
              alignment: Alignment.center,
              child: Icon(
                Icons.chevron_left,
              ),
            ),
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                child: Text(category),
                value: category,
              );
            }).toList(),
            onChanged: (String value) =>
                context.read<PostFormBloc>().add(CategoryUpdated(value)),
          ),
        ),
      ],
    );
  }
}

class _SubmitControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubmitControlState();
}

class _SubmitControlState extends State<_SubmitControl> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostFormBloc, PostFormState>(
      builder: (context, state) {
        final loadedState = state as PostFormLoadSuccess;
        return Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: loadedState.status.isValidated ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: FlutterSlider(
              values: [_value],
              onDragCompleted: loadedState.status.isValidated
                  ? (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        _value = 0.0;
                      });
                    }
                  : null,
              disabled: loadedState.status.isValidated == false ? true : false,
              min: 0,
              max: 100,
              tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: false,
                disabled: true,
              ),
              handlerWidth: 60,
              handlerHeight: 30,
              handler: FlutterSliderHandler(
                opacity: loadedState.status.isValidated ? 1.0 : 0.0,
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: LiveFeedTheme.theme.accentColor,
                  border: Border.all(
                    color: LiveFeedTheme.theme.accentColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              trackBar: FlutterSliderTrackBar(
                centralWidget: Text(
                  loadedState.status.isValidated
                      ? 'Slide & add to LiveFEED'
                      : 'Fill out all the fields and add\nat least 1 photo or video',
                  textAlign: TextAlign.center,
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    color: loadedState.status.isValidated
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: loadedState.status.isValidated
                      ? Colors.black
                      : Colors.white,
                  border: Border.all(width: 3, color: Colors.black),
                ),
                activeTrackBarHeight: 0.01,
                inactiveTrackBarHeight: 0.01,
                activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
