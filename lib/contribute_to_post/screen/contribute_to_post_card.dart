import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livefeed/common/widgets/location_field.dart';
import 'package:livefeed/common/widgets/media_upload_field.dart';
import 'package:livefeed/theme.dart';
import 'package:flutter/services.dart';

class ContributeToPostCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContributeToPostCardState();
}

class _ContributeToPostCardState extends State<ContributeToPostCard> {
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
            MediaUploadField(),
            const Padding(padding: EdgeInsets.only(top: 10)),
            LocationField((newAddress, newZipCode) {
              setState(() {
                address = newAddress;
                zipCode = newZipCode;
              });
            }),
            // _LocationControl(),
            // PostAddressControl(
            //   (newAddress, newZipCode) {
            //     print('newAddress: $newAddress, newZipCode: $newZipCode');
            //     setState(() {
            //       address = newAddress;
            //       zipCode = newZipCode;
            //     });
            //   },
            // ),
            FlatButton(
              minWidth: double.infinity,
              onPressed: () {},
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: LiveFeedTheme.theme.highlightColor,
                ),
              ),
            ),
            FlatButton(
              minWidth: double.infinity,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            // const Padding(padding: EdgeInsets.only(top: 10)),
            // _SubmitControl(),
          ],
        ),
      ),
    );
  }
}

class _HeadlineInput extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      maxLength: 80,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
        hintText: 'Headline...',
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
        hintStyle: LiveFeedTheme.theme.inputDecorationTheme.hintStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      maxLength: 2000,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
        hintText: 'Description...',
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
        hintStyle: LiveFeedTheme.theme.inputDecorationTheme.hintStyle.copyWith(
          color: Colors.grey,
        ),
      ),
      style: LiveFeedTheme.theme.textTheme.bodyText1,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
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
            onChanged: (String value) {},
          ),
        ),
      ],
    );
  }
}

class _LocationControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationControlState();
}

class _LocationControlState extends State<_LocationControl> {
  String _address = 'Chicago, IL';
  String _zipCode = '60606';
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LOCATION'),
          const Padding(padding: EdgeInsets.only(top: 5)),
          _LocationInput(
            _address,
            _zipCode,
            (newAddress) {
              setState(() {
                _address = newAddress;
              });
            },
            (newZipCode) {
              _zipCode = newZipCode;
            },
            () {
              setState(() {
                _editing = false;
              });
            },
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LOCATION'),
          const Padding(padding: EdgeInsets.only(top: 5)),
          ListTile(
            tileColor: Colors.grey[200],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_pin,
                  color: LiveFeedTheme.theme.highlightColor,
                ),
                Text(
                  '$_address $_zipCode',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () => setState(() {
                _editing = true;
              }),
              child: Text(
                'Edit',
                style: TextStyle(
                  color: LiveFeedTheme.theme.highlightColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ],
      );
    }
  }
}

class _LocationInput extends StatefulWidget {
  final String initialAddress;
  final String initialZipCode;
  final Function(String address) onAddressUpdated;
  final Function(String zipCode) onZipCodeUpdated;
  final Function onEditCompleted;

  _LocationInput(
    this.initialAddress,
    this.initialZipCode,
    this.onAddressUpdated,
    this.onZipCodeUpdated,
    this.onEditCompleted,
  );

  @override
  State<StatefulWidget> createState() => _LocationInputState(
        initialAddress,
        initialZipCode,
        onAddressUpdated,
        onZipCodeUpdated,
        onEditCompleted,
      );
}

class _LocationInputState extends State<_LocationInput> {
  final TextEditingController addressTextController = TextEditingController();
  final TextEditingController zipTextController = TextEditingController();
  final String initialAddress;
  final String initialZipCode;
  String _currentAddress = '';
  String _currentZipCode = '';
  final Function(String address) onAddressUpdated;
  final Function(String zipCode) onZipCodeUpdated;
  final Function onEditCompleted;

  _LocationInputState(
    this.initialAddress,
    this.initialZipCode,
    this.onAddressUpdated,
    this.onZipCodeUpdated,
    this.onEditCompleted,
  );

  @override
  void initState() {
    _currentAddress = initialAddress;
    _currentZipCode = initialZipCode;
    addressTextController.text = _currentAddress;
    zipTextController.text = _currentZipCode;
    super.initState();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    var position = await Geolocator.getCurrentPosition();

    print(position.toString());

    try {
      List<Placemark> p =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = p[0];
      print(place);

      setState(() {
        _currentAddress = "${place.locality}, ${place.administrativeArea}";
        _currentZipCode = place.postalCode;
        addressTextController.text = _currentAddress;
        zipTextController.text = _currentZipCode;
        onAddressUpdated(_currentAddress);
        onZipCodeUpdated(_currentZipCode);
      });
    } catch (e) {
      print(e);
    }

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: addressTextController,
                onChanged: (value) => this.onAddressUpdated(value),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  height: 1.55,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Address',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    height: 1.55,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Expanded(
              child: TextField(
                controller: zipTextController,
                onChanged: (value) => this.onZipCodeUpdated(value),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  height: 1.55,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Zip code',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    height: 1.55,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            GestureDetector(
              onTap: this.onEditCompleted,
              child: Icon(Icons.check),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        Container(
          width: double.infinity,
          child: GestureDetector(
            onTap: () => _determinePosition(),
            child: Text(
              'Use my location',
              textAlign: TextAlign.center,
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                color: LiveFeedTheme.theme.highlightColor,
              ),
            ),
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
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: FlutterSlider(
          values: [_value],
          onDragCompleted: (handlerIndex, lowerValue, upperValue) {
            setState(() {
              _value = 0.0;
            });
          },
          min: 0,
          max: 100,
          tooltip: FlutterSliderTooltip(
            alwaysShowTooltip: false,
            disabled: true,
          ),
          handlerWidth: 60,
          handlerHeight: 30,
          handler: FlutterSliderHandler(
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
              'Slide & add to LiveFEED',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            inactiveTrackBar: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
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
  }
}
