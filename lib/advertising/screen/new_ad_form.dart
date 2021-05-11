import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/advertising/bloc/ad_form/ad_form_bloc.dart';
import 'package:livefeed/advertising/models/current_ad.dart';
import 'package:livefeed/common/widgets/location_field.dart';
import 'package:livefeed/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class NewAdForm extends StatelessWidget {
  Widget _buildDesignForms() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 4. Do you need any help with design, or would you like to upload a finished ad?',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          _CreateDesignControl(),
          const Padding(padding: EdgeInsets.only(top: 10)),
          _UploadDesignControl(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mainColumn = Column(
      children: [
        _CardHeader(),
        const Padding(padding: EdgeInsets.only(top: 10)),
        _WhyLiveFeedDisplay(),
        const Padding(padding: EdgeInsets.only(top: 30)),
        _TargetMarketControl(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: LocationField(
            (newAddress, newZipCode) {},
            fieldLabel: 'CITY',
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        _TargetViewControl(),
        const Padding(padding: EdgeInsets.only(top: 30)),
        _buildDesignForms(),
        const Padding(padding: EdgeInsets.only(top: 30)),
        _CheckoutButton(),
        const Padding(padding: EdgeInsets.only(top: 20)),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: Colors.white,
      ),
      child: mainColumn,
    );
  }
}

class _CardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'CREATE NEW AD',
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}

class _WhyLiveFeedDisplay extends StatelessWidget {
  Expanded _buildLabel(String graphicImagePath, String labelText) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(graphicImagePath),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            Text(
              labelText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 1. Why LiveFEED?',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(
                'assets/images/local_global3x.png',
                'Local or global reach right at your fingertips',
              ),
              _buildLabel(
                'assets/images/affordable3x.png',
                'Affordable cost',
              ),
              _buildLabel(
                'assets/images/full_control3x.png',
                'Full control. No long-term contracts.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TargetMarketControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TargetMarketControlState();
}

class _TargetMarketControlState extends State<_TargetMarketControl> {
  List<Widget> _buildButtons(TargetMarket currentTargetMarket) {
    return TargetMarket.values.map((targetMarket) {
      var label = '';
      var labelImagePath = '';
      switch (targetMarket) {
        case TargetMarket.worldwide:
          label = 'Worldwide';
          labelImagePath = 'assets/images/worldwide_layers3x.png';
          break;
        case TargetMarket.local:
          label = 'Local';
          labelImagePath = 'assets/images/local_layers3x.png';
          break;
        case TargetMarket.hyperlocal:
          label = 'Hyperlocal';
          labelImagePath = 'assets/images/local_layers3x.png';
          break;
      }
      return _TargetMarketButton(
        targetMarket == currentTargetMarket,
        label,
        labelImagePath,
        targetMarket,
        onTapped: (value) =>
            context.read<AdFormBloc>().add(TargetMarketUpdated(targetMarket)),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdFormBloc, AdFormState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step 2. Choose your target market:',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              ..._buildButtons(state.targetMarket),
            ],
          ),
        );
      },
    );
  }
}

class _TargetMarketButton extends StatelessWidget {
  final bool selected;
  final String label;
  final String labelImagePath;
  final TargetMarket value;
  final Function(TargetMarket) onTapped;

  _TargetMarketButton(
    this.selected,
    this.label,
    this.labelImagePath,
    this.value, {
    this.onTapped,
  });

  Widget _buildCheckMark() {
    return Positioned(
      right: 5,
      top: 5,
      child: Icon(
        Icons.check_circle,
        color: selected ? LiveFeedTheme.theme.highlightColor : Colors.grey[200],
        size: 15,
      ),
    );
  }

  Widget _buildRecommendedLabel(BuildContext context) {
    return Positioned(
      right: 10,
      top: MediaQuery.of(context).size.height * 0.1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          color: LiveFeedTheme.theme.highlightColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 3,
          ),
          child: Text(
            'RECOMMENDED',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelVisual() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            height: value == TargetMarket.worldwide ? 30 : 20,
            width: value == TargetMarket.worldwide ? 30 : 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(labelImagePath),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Text(
            label,
            style: TextStyle(
              fontSize: value == TargetMarket.worldwide ? 20 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => onTapped(value),
              child: Container(
                width: double.infinity,
                height: value == TargetMarket.worldwide ? 140 : 80,
                decoration: BoxDecoration(
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                      : null,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    width: 1.0,
                    color: selected
                        ? LiveFeedTheme.theme.highlightColor
                        : Colors.grey[200],
                  ),
                  color: Colors.white,
                ),
                child: _buildLabelVisual(),
              ),
            ),
          ),
          if (selected) _buildCheckMark(),
          if (value == TargetMarket.worldwide) _buildRecommendedLabel(context),
        ],
      ),
    );
  }
}

class _TargetViewControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TargetViewControlState();
}

class _TargetViewControlState extends State<_TargetViewControl> {
  List<Widget> _buildButtons(TargetView currentTargetView) {
    var bottomRow = Flex(
      direction: Axis.horizontal,
      children: [],
    );
    var toReturnList = <Widget>[];
    TargetView.values.forEach((targetView) {
      var label = '';
      var labelImagePath = '';
      switch (targetView) {
        case TargetView.timeline_post:
          label = 'Both views';
          labelImagePath = 'assets/images/target_post3x.png';
          toReturnList.add(
            _TargetViewButton(
              targetView == currentTargetView,
              label,
              targetView,
              labelImagePath,
              onTapped: (value) =>
                  context.read<AdFormBloc>().add(TargetViewUpdated(targetView)),
            ),
          );
          break;
        case TargetView.timeline:
          label = 'Timeline view';
          labelImagePath = 'assets/images/target_post3x.png';
          bottomRow.children.add(
            Expanded(
              child: _TargetViewButton(
                targetView == currentTargetView,
                label,
                targetView,
                labelImagePath,
                onTapped: (value) => context
                    .read<AdFormBloc>()
                    .add(TargetViewUpdated(targetView)),
              ),
            ),
          );
          break;
        case TargetView.post:
          label = 'Post view';
          labelImagePath = 'assets/images/target_post3x.png';
          bottomRow.children.add(
            Expanded(
              child: _TargetViewButton(
                targetView == currentTargetView,
                label,
                targetView,
                labelImagePath,
                onTapped: (value) => context
                    .read<AdFormBloc>()
                    .add(TargetViewUpdated(targetView)),
              ),
            ),
          );
          break;
      }
    });

    toReturnList.add(bottomRow);

    return toReturnList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdFormBloc, AdFormState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step 3. Choose the size of your ad:',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              ..._buildButtons(state.targetView),
            ],
          ),
        );
      },
    );
  }
}

class _TargetViewButton extends StatelessWidget {
  final bool selected;
  final String label;
  final TargetView value;
  final String labelImagePath;
  final Function(TargetView) onTapped;

  _TargetViewButton(
    this.selected,
    this.label,
    this.value,
    this.labelImagePath, {
    this.onTapped,
  });

  Widget _buildCheckMark() {
    return Positioned(
      right: 5,
      top: 5,
      child: Icon(
        Icons.check_circle,
        color: selected ? LiveFeedTheme.theme.highlightColor : Colors.grey[200],
        size: 15,
      ),
    );
  }

  Widget _buildRecommendedLabel(BuildContext context) {
    return Positioned(
      right: 10,
      top: MediaQuery.of(context).size.height * 0.05,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          color: LiveFeedTheme.theme.highlightColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 3,
          ),
          child: Text(
            'RECOMMENDED',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelVisual() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            // width: value == TargetView.timeline ? 80 : 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(labelImagePath),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => onTapped(value),
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                      : null,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    width: 1.0,
                    color: selected
                        ? LiveFeedTheme.theme.highlightColor
                        : Colors.grey[200],
                  ),
                  color: Colors.white,
                ),
                child: _buildLabelVisual(),
              ),
            ),
          ),
          if (selected) _buildCheckMark(),
          if (value == TargetView.timeline_post)
            _buildRecommendedLabel(context),
        ],
      ),
    );
  }
}

class _CreateDesignControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(width: 1.0, color: Colors.grey[400]),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please create design for me',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Upload your logo and description of your product/services here (jpg, png, pdf - anything you’ve got)',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      hintText: 'Description',
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
                      hintStyle: LiveFeedTheme
                          .theme.inputDecorationTheme.hintStyle
                          .copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  _MediaUploadContainer(),
                ],
              ),
            ),
          ),
          Positioned(
            top: -2,
            right: 0,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/feather3x.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadDesignControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(width: 1.0, color: Colors.grey[400]),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I\'ve got it!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Upload your finished ad here',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  _MediaUploadContainer(),
                ],
              ),
            ),
          ),
          Positioned(
            top: -7,
            right: 0,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/cloud_computing3x.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaUploadContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MediaUploadContainerState();
}

class _MediaUploadContainerState extends State<_MediaUploadContainer> {
  File _image;
  final picker = ImagePicker();

  Future imageFromGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );

    setState(() {
      if (pickedFile != null) {
        try {
          _image = File(pickedFile.path);
          return;
        } catch (e) {}
      } else {
        print('No image selected');
      }
    });
  }

  Future imageFromCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );

    setState(() {
      if (picker != null) {
        print(pickedFile.path);
        try {
          _image = File(pickedFile.path);
          return;
        } catch (e) {}
      } else {
        print('No image selected');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      imageFromGallery(context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    imageFromCamera(context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey[400],
      strokeWidth: 2,
      dashPattern: [12],
      borderType: BorderType.RRect,
      child: GestureDetector(
        onTap: () {
          _showPicker(context);
        },
        child: _image != null
            ? Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(_image),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 25)),
                    Container(
                      width: 38,
                      height: 38,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image(
                          image: AssetImage('assets/images/upload_image.png'),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    RichText(
                      text: TextSpan(
                        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Click here',
                            style: LiveFeedTheme.theme.textTheme.bodyText1
                                .copyWith(
                              color: LiveFeedTheme.theme.highlightColor,
                            ),
                          ),
                          TextSpan(text: ' to upload photo/video'),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 25)),
                  ],
                ),
              ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final Function onPressed;

  _SubmitButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: double.infinity,
      color: Colors.grey[850],
      onPressed: () => this.onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'SUBMIT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _CheckoutButton extends StatelessWidget {
  final Function onPressed;

  _CheckoutButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FlatButton(
        minWidth: double.infinity,
        color: Colors.grey[850],
        onPressed: () => this.onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'CHECKOUT (\$199)',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
