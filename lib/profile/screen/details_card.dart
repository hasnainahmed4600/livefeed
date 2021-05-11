import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livefeed/profile/bloc/profile_bloc.dart';
import 'package:livefeed/theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';

class DetailsCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DetailsCardState();
}

class DetailsCardState extends State<DetailsCard> {
  final double rating = 7.0;
  String userName = 'Leo Knight';
  String address = 'Chicago, IL';
  String zipCode = '60606';
  final String email = 'leoknight232@gmail.com';
  final String phoneIsoCode = 'US';
  final String phoneCountryCode = '1';
  final String phoneNumber = '4567890';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          width: 1.0,
          color: Colors.grey[400],
        ),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Container(
            height: 140.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image(
                image: AssetImage('assets/images/connection_links.png'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 175),
            child: _RatingGauge(rating),
          ),
          Positioned(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 85)),
                _AvatarImage(),
                const Padding(padding: EdgeInsets.only(top: 15)),
                _UserSummary(userName, '$address $zipCode'),
                //const Padding(padding: EdgeInsets.only(top: 5)),
                //_RatingGauge(rating),
                const Padding(padding: EdgeInsets.only(top: 220)),
                _RatingDisplay(rating),
                const Padding(padding: EdgeInsets.only(top: 25)),
                _UsernameControl(userName, (newName) {
                  setState(() {
                    userName = newName;
                  });
                }),
                const Padding(padding: EdgeInsets.only(top: 25)),
                _AddressControl(
                  (newAddress, newZipCode) {
                    setState(() {
                      address = newAddress;
                      zipCode = newZipCode;
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 25)),
                _EmailControl(email),
                const Padding(padding: EdgeInsets.only(top: 25)),
                _PhoneNumberControl(
                    phoneIsoCode, phoneCountryCode, phoneNumber),
                const Padding(padding: EdgeInsets.only(top: 25)),
                _LogoutButton(),
                const Padding(padding: EdgeInsets.only(top: 25)),
                // _UpdateProfileButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AvatarImageState();
}

class _AvatarImageState extends State<_AvatarImage> {
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
    Widget avatarBubble = Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(180),
        color: Colors.grey,
        image: _image == null
            ? null
            : DecorationImage(
                image: FileImage(_image),
                fit: BoxFit.cover,
              ),
      ),
      clipBehavior: Clip.hardEdge,
      child: _image == null
          ? Container(
              width: double.infinity,
              height: double.infinity,
              child: GestureDetector(
                onTap: () => _showPicker(context),
                behavior: HitTestBehavior.opaque,
                child: Center(
                  child: Text(
                    'ADD PICTURE',
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      color: LiveFeedTheme.theme.highlightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          : Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  await _image.delete();
                  setState(() {
                    _image = null;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  width: double.infinity,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
      // child: GestureDetector(
      //   onTap: () => _showPicker(context),
      //   child: CircleAvatar(
      //     backgroundColor: Colors.grey,
      //     foregroundColor: Colors.white,
      //     radius: 2,
      //     backgroundImage: _image == null ? null : FileImage(_image),
      //     child: _image == null
      //         ? Text(
      //             'ADD PICTURE',
      //             style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
      //               color: LiveFeedTheme.theme.highlightColor,
      //               fontWeight: FontWeight.bold,
      //             ),
      //             textAlign: TextAlign.center,
      //           )
      //         : Align(
      //             alignment: Alignment.bottomCenter,
      //             child: Container(
      //               color: Colors.black,
      //               width: double.infinity,
      //               child: Icon(Icons.delete),
      //             ),
      //           ),
      //   ),
      // ),
    );
    return avatarBubble;
    // if (_image != null) {
    //   return Stack(
    //     children: [
    //       avatarBubble,
    //       Positioned(
    //         bottom: -10,
    //         right: -5,
    //         child: Container(
    //           child: IconButton(
    //             onPressed: () async {
    //               await _image.delete();
    //               setState(() {
    //                 _image = null;
    //               });
    //             },
    //             icon: Icon(
    //               Icons.delete,
    //               color: Colors.red,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   );
    // } else
    //   return avatarBubble;
  }
}

class _UserSummary extends StatelessWidget {
  final String name;
  final String address;

  _UserSummary(this.name, this.address);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_pin,
              color: LiveFeedTheme.theme.highlightColor,
              size: 15,
            ),
            Text(
              address,
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                color: LiveFeedTheme.theme.highlightColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RatingGauge extends StatelessWidget {
  final double _rating;

  const _RatingGauge(rating)
      : assert(rating <= 10.0),
        assert(rating >= 0.0),
        _rating = rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 10,
            startAngle: 180,
            endAngle: 0,
            interval: 1,
            canScaleToFit: true,
            showLabels: false,
            showTicks: false,
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 10,
                endWidth: 55,
                startWidth: 55,
                gradient: const SweepGradient(
                  colors: <Color>[
                    Colors.red,
                    Colors.yellow,
                    Colors.green,
                  ],
                  stops: <double>[
                    0.25,
                    0.50,
                    0.95,
                  ],
                ),
              ),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(value: _rating),
            ],
            // annotations: <GaugeAnnotation>[
            //   GaugeAnnotation(
            //     widget: Container(
            //       child: Text(
            //         '7.0',
            //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     angle: 7,
            //     positionFactor: 0.5,
            //   ),
            // ],
          )
        ],
      ),
    );
  }
}

class _RatingDisplay extends StatefulWidget {
  final double _rating;

  const _RatingDisplay(rating)
      : assert(rating <= 10.0),
        assert(rating >= 0.0),
        _rating = rating;

  @override
  State<StatefulWidget> createState() => _RatingDisplayState(_rating);
}

class _RatingDisplayState extends State<_RatingDisplay> {
  final double _rating;
  bool expanded = false;

  _RatingDisplayState(rating)
      : assert(rating <= 10.0),
        assert(rating >= 0.0),
        _rating = rating;

  @override
  Widget build(BuildContext context) {
    var mainColumn = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _rating.toString(),
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontSize: 25.0,
            fontWeight: FontWeight.w800,
            color: Color.fromRGBO(126, 211, 33, 1),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Text(
          'LiveFEED Member Score',
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Text(
          'Learn more',
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            color: LiveFeedTheme.theme.highlightColor,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
    if (expanded) {
      mainColumn.children.add(
        Padding(padding: EdgeInsets.only(top: 15)),
      );
      mainColumn.children.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Our unique score system comprised of multiple factors, including your submitted content and interactions on the platform.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: GestureDetector(
        onTap: () {
          setState(() {
            expanded = !expanded;
          });
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(247, 248, 249, 1),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: mainColumn,
          ),
        ),
      ),
    );
  }
}

class _AddressControl extends StatefulWidget {
  final Function(String address, String zipCode) onAddressUpdated;

  _AddressControl(this.onAddressUpdated);

  @override
  State<StatefulWidget> createState() => _AddressControlState(onAddressUpdated);
}

class _AddressControlState extends State<_AddressControl> {
  bool _editing = false;
  String currentAddress = 'Chicago, IL';
  String currentZipCode = '60606';
  final Function(String address, String zipCode) onAddressUpdated;

  _AddressControlState(this.onAddressUpdated);

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      return _AddressSearchControl(
        currentAddress,
        currentZipCode,
        (zip, address) {
          setState(
            () {
              currentAddress = address;
              currentZipCode = zip;
              _editing = false;
              onAddressUpdated(currentAddress, currentZipCode);
            },
          );
        },
        () {
          setState(() {
            _editing = false;
          });
        },
      );
    } else {
      return _AddressDisplay(
        currentAddress,
        currentZipCode,
        () {
          setState(
            () {
              _editing = true;
            },
          );
        },
      );
    }
  }
}

class _AddressDisplay extends StatelessWidget {
  final String address;
  final String zipCode;
  final Function onEditTapped;

  _AddressDisplay(this.address, this.zipCode, this.onEditTapped);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        tileColor: Color.fromRGBO(247, 248, 249, 1),
        title: Text(
          '$address $zipCode',
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: GestureDetector(
          onTap: this.onEditTapped,
          child: Text(
            'Edit',
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              color: LiveFeedTheme.theme.highlightColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddressSearchControl extends StatefulWidget {
  final String initialZipCode;
  final String initialAddress;
  final Function(String zip, String address) onAddressSelected;
  final Function onEditCancelled;

  _AddressSearchControl(
    this.initialAddress,
    this.initialZipCode,
    this.onAddressSelected,
    this.onEditCancelled,
  );

  @override
  State<StatefulWidget> createState() => _AddressSearchControlState(
        initialAddress,
        initialZipCode,
        this.onAddressSelected,
        this.onEditCancelled,
      );
}

class _AddressSearchControlState extends State<_AddressSearchControl> {
  _AddressSearchControlState(
    this.initialAddress,
    this.initialZipCode,
    this.onAddressSelected,
    this.onEditCancelled,
  );

  bool _searching = false;
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _zipTextController = TextEditingController();
  String _currentAddress = 'Chicago, IL';
  String _currentZipCode = '60606';
  final String initialAddress;
  final String initialZipCode;
  final Function(String zip, String address) onAddressSelected;
  final Function onEditCancelled;

  Map<String, String> _addresses = {
    '60606': 'Chicago, IL',
    '10001': 'Brooklyn, NY',
    '10013': 'New York, NY',
    '10011': 'New York, NY',
  };

  Map<String, String> _addressSearchResults = {};

  @override
  void initState() {
    _currentAddress = initialAddress;
    _currentZipCode = initialZipCode;
    _addressTextController.text = _currentAddress;
    _zipTextController.text = _currentZipCode;
    super.initState();
  }

  void updateAddress(String address) {
    setState(() {
      _currentAddress = address;
      if (address != initialAddress && address.length > 0) {
        _searching = true;

        var searchResults = Map<String, String>();
        _addresses.forEach((key, value) {
          if (/*key.toLowerCase().contains(_currentZipCode.toLowerCase()) &&*/
              value.toLowerCase().contains(address.toLowerCase())) {
            searchResults.addAll({key: value});
          }
        });

        _addressSearchResults = searchResults;
      } else if (address.length < 1 /* && _currentZipCode.length < 1 */) {
        _addressSearchResults = {};
      }
    });
  }

  void updateZipCode(String zipCode) {
    setState(() {
      _currentZipCode = zipCode;
      if (zipCode != initialZipCode && zipCode.length > 0) {
        _searching = true;

        var searchResults = Map<String, String>();
        _addresses.forEach((key, value) {
          if (key.toLowerCase().contains(zipCode
                  .toLowerCase()) /* &&
              value.toLowerCase().contains(_currentAddress.toLowerCase()) */
              ) {
            searchResults.addAll({key: value});
          }
        });

        _addressSearchResults = searchResults;
      } else if (zipCode.length < 1 /* && _currentAddress.length < 1 */) {
        _addressSearchResults = {};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mainColumn = Column(
      children: [
        _AddressInput(
          _addressTextController,
          _zipTextController,
          // currentAddress,
          // currentZipCode,
          (address) {
            updateAddress(address);
          },
          (zipCode) {
            updateZipCode(zipCode);
          },
          this.onEditCancelled,
        ),
      ],
    );
    if (_searching) {
      mainColumn.children.add(_AddressSearchResults(
        _addressSearchResults,
        this.onAddressSelected,
      ));
    }
    return mainColumn;
  }
}

class _AddressInput extends StatelessWidget {
  final _addressTextController;
  final _zipTextController;

  // final String initialAddress;
  // final String initialZipCode;
  final Function(String address) onAddressUpdated;
  final Function(String zipCode) onZipCodeUpdated;
  final Function onEditCancelled;

  _AddressInput(
    this._addressTextController,
    this._zipTextController,
    // this.initialAddress,
    // this.initialZipCode,
    this.onAddressUpdated,
    this.onZipCodeUpdated,
    this.onEditCancelled,
  );

  @override
  Widget build(BuildContext context) {
    // _addressTextController.text = initialAddress;
    // _zipTextController.text = initialZipCode;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 160,
            child: TextField(
              controller: _addressTextController,
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
          Container(
            width: 120,
            child: TextField(
              controller: _zipTextController,
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
          GestureDetector(
            onTap: this.onEditCancelled,
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class _AddressSearchResults extends StatelessWidget {
  final Map<String, String> results;
  final Function(String zip, String address) onAddressSelected;

  _AddressSearchResults(this.results, this.onAddressSelected);

  @override
  Widget build(BuildContext context) {
    if (results.length > 0) {
      var mainColumn = Column(children: []);

      results.forEach((key, value) {
        mainColumn.children.add(ListTile(
          onTap: () => this.onAddressSelected(key, value),
          title: Text(value),
          trailing: Text(key),
        ));
        mainColumn.children.add(Divider(
          thickness: 1,
          height: 1,
        ));
      });

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: mainColumn,
      );
    } else {
      return Text('No search results');
    }
  }
}

class _UsernameControl extends StatefulWidget {
  final String initialName;
  final Function(String) onNameUpdated;

  _UsernameControl(this.initialName, this.onNameUpdated);

  @override
  State<StatefulWidget> createState() =>
      _UsernameControlState(initialName, onNameUpdated);
}

class _UsernameControlState extends State<_UsernameControl> {
  _UsernameControlState(
    this.initialName,
    this.onNameUpdated,
  );

  bool _editing = false;
  TextEditingController _textController = TextEditingController();
  String initialName;
  final Function(String) onNameUpdated;

  @override
  void initState() {
    _textController.text = initialName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      return _UsernameInput(
        initialName,
        this._textController,
        (name) {
          setState(() {
            _editing = false;
            initialName = name;
            _textController.text = initialName;
            onNameUpdated(name);
          });
        },
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: ListTile(
          tileColor: Color.fromRGBO(247, 248, 249, 1),
          title: Text(
            initialName,
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                _editing = true;
              });
            },
            child: Text(
              'Edit',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                color: LiveFeedTheme.theme.highlightColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
  }
}

class _UsernameInput extends StatefulWidget {
  final TextEditingController textController;
  final String initialText;
  final Function(String email) onNameSaved;

  _UsernameInput(this.initialText, this.textController, this.onNameSaved);

  @override
  State<StatefulWidget> createState() =>
      _UsernameInputState(initialText, textController, onNameSaved);
}

class _UsernameInputState extends State<_UsernameInput> {
  final TextEditingController textController;
  final String initialText;
  String _currentText;
  bool _canSave = false;
  bool _invalid = false;
  String _validationError = '';
  final Function(String email) onNameSaved;

  _UsernameInputState(
    this.initialText,
    this.textController,
    this.onNameSaved,
  );

  @override
  void initState() {
    _currentText = initialText;
    super.initState();
  }

  void updateName(String updatedName) {
    setState(() {
      _currentText = updatedName;
      if (_currentText != initialText && _currentText.length > 0) {
        _canSave = true;
        _invalid = false;
        _validationError = '';
      } else {
        _canSave = false;
        _invalid = true;
        _validationError = 'Required';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: textController,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          height: 1.55,
          fontSize: 14,
        ),
        onChanged: (value) => updateName(value),
        decoration: InputDecoration(
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: 'Email',
          suffix: GestureDetector(
            onTap: _canSave ? () => this.onNameSaved(_currentText) : null,
            child: Icon(
              Icons.check,
              size: 19,
              color:
                  _canSave ? LiveFeedTheme.theme.highlightColor : Colors.grey,
            ),
          ),
          errorText: _invalid ? _validationError : null,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            height: 1.55,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _EmailControl extends StatefulWidget {
  final String initialEmail;

  _EmailControl(this.initialEmail);

  @override
  State<StatefulWidget> createState() => _EmailControlState(initialEmail);
}

class _EmailControlState extends State<_EmailControl> {
  _EmailControlState(
    this.initialEmail,
  );

  bool _editing = false;
  TextEditingController _textController = TextEditingController();
  String initialEmail;

  @override
  void initState() {
    _textController.text = initialEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      return _EmailInput(
        initialEmail,
        this._textController,
        (email) {
          setState(() {
            _editing = false;
            initialEmail = email;
            _textController.text = initialEmail;
          });
        },
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: ListTile(
          tileColor: Color.fromRGBO(247, 248, 249, 1),
          title: Text(
            initialEmail,
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                _editing = true;
              });
            },
            child: Text(
              'Edit',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                color: LiveFeedTheme.theme.highlightColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
  }
}

class _EmailInput extends StatefulWidget {
  final TextEditingController textController;
  final String initialText;
  final Function(String email) onEmailSaved;

  _EmailInput(this.initialText, this.textController, this.onEmailSaved);

  @override
  State<StatefulWidget> createState() =>
      _EmailInputState(initialText, textController, onEmailSaved);
}

class _EmailInputState extends State<_EmailInput> {
  final TextEditingController textController;
  final String initialText;
  String _currentText;
  bool _canSave = false;
  bool _invalid = false;
  String _validationError = '';
  final Function(String email) onEmailSaved;

  _EmailInputState(
    this.initialText,
    this.textController,
    this.onEmailSaved,
  );

  @override
  void initState() {
    _currentText = initialText;
    super.initState();
  }

  void updateEmail(String updatedEmail) {
    setState(() {
      _currentText = updatedEmail;
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_currentText);
      if (_currentText != initialText && emailValid) {
        _canSave = true;
        _invalid = false;
        _validationError = '';
      } else {
        _canSave = false;
        _invalid = true;
        _validationError = 'Please write a valid email';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: textController,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          height: 1.55,
          fontSize: 14,
        ),
        onChanged: (value) => updateEmail(value),
        decoration: InputDecoration(
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: 'Email',
          suffix: GestureDetector(
            onTap: _canSave ? () => this.onEmailSaved(_currentText) : null,
            child: Icon(
              Icons.check,
              size: 19,
              color:
                  _canSave ? LiveFeedTheme.theme.highlightColor : Colors.grey,
            ),
          ),
          errorText: _invalid ? _validationError : null,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            height: 1.55,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberControl extends StatefulWidget {
  final String initialIsoCode;
  final String initialCountryCode;
  final String initialNumber;

  _PhoneNumberControl(
    this.initialIsoCode,
    this.initialCountryCode,
    this.initialNumber,
  );

  @override
  State<StatefulWidget> createState() => _PhoneNumberControlState(
      initialIsoCode, initialCountryCode, initialNumber);
}

class _PhoneNumberControlState extends State<_PhoneNumberControl> {
  String initialIsoCode;
  String initialCountryCode;
  String initialNumber;
  bool _editing = false;

  _PhoneNumberControlState(
      this.initialIsoCode, this.initialCountryCode, this.initialNumber);

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      return _PhoneNumberInput(
        initialIsoCode,
        initialCountryCode,
        initialNumber,
        (isoCode, countryCode, number) {
          setState(() {
            _editing = false;
            initialIsoCode = isoCode;
            initialCountryCode = countryCode;
            initialNumber = number;
          });
        },
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: ListTile(
          tileColor: Color.fromRGBO(247, 248, 249, 1),
          title: Text(
            '+($initialCountryCode) $initialNumber',
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                _editing = true;
              });
            },
            child: Text(
              'Edit',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                color: LiveFeedTheme.theme.highlightColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
  }
}

class _PhoneNumberInput extends StatefulWidget {
  final String initialIsoCode;
  final String initialCountryCode;
  final String initialPhoneNumber;
  final Function(String isoCode, String countryCode, String number)
      onPhoneNumberSubmitted;

  _PhoneNumberInput(
    this.initialIsoCode,
    this.initialCountryCode,
    this.initialPhoneNumber,
    this.onPhoneNumberSubmitted,
  );

  @override
  State<StatefulWidget> createState() => _PhoneNumberInputState(
        initialIsoCode,
        initialCountryCode,
        initialPhoneNumber,
        onPhoneNumberSubmitted,
      );
}

class _PhoneNumberInputState extends State<_PhoneNumberInput> {
  final _textController = TextEditingController();
  final String initialIsoCode;
  final String initialCountryCode;
  final String initialPhoneNumber;
  String _currentIsoCode;
  String _currentCountryCode;
  String _currentPhoneNumber;
  bool _canSave = false;
  bool _invalid = false;
  String _validationError = '';
  final Function(String isoCode, String countryCode, String number)
      onPhoneNumberSubmitted;

  _PhoneNumberInputState(
    this.initialIsoCode,
    this.initialCountryCode,
    this.initialPhoneNumber,
    this.onPhoneNumberSubmitted,
  );

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 2.0,
            ),
            Text("+${country.phoneCode}"),
          ],
        ),
      );

  @override
  void initState() {
    _currentIsoCode = initialIsoCode;
    _currentCountryCode = initialCountryCode;
    _currentPhoneNumber = initialPhoneNumber;
    _textController.text = _currentPhoneNumber;
    super.initState();
  }

  void countryCodeUpdated(String newIsoCode, String newCountryCode) {
    setState(() {
      _currentIsoCode = newIsoCode;
      _currentCountryCode = newCountryCode;
      if (_currentCountryCode != initialCountryCode ||
          _currentPhoneNumber != initialPhoneNumber) {
        final isNumeric = RegExp(r'^[0-9]+$').hasMatch(_currentPhoneNumber);
        if (_currentPhoneNumber.length < 7) {
          _canSave = false;
          _invalid = true;
          _validationError = 'Please enter at least 7 digits';
        } else if (!isNumeric) {
          _canSave = false;
          _invalid = true;
          _validationError = 'Only numbers allowed';
        } else {
          _canSave = true;
          _invalid = false;
          _validationError = '';
        }
      } else {
        _canSave = false;
      }
    });
  }

  void phoneNumberUpdated(String newPhoneNumber) {
    setState(() {
      _currentPhoneNumber = newPhoneNumber;
      if (_currentCountryCode != initialCountryCode ||
          _currentPhoneNumber != initialPhoneNumber) {
        final isNumeric = RegExp(r'^[0-9]+$').hasMatch(_currentPhoneNumber);
        if (_currentPhoneNumber.length < 7) {
          _canSave = false;
          _invalid = true;
          _validationError = 'Please enter at least 7 digits';
        } else if (!isNumeric) {
          _canSave = false;
          _invalid = true;
          _validationError = 'Only numbers allowed';
        } else {
          _canSave = true;
          _invalid = false;
          _validationError = '';
        }
      } else {
        _canSave = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          CountryPickerDropdown(
            initialValue: initialIsoCode,
            itemBuilder: _buildDropdownItem,
            itemFilter: (c) => countryCodes.contains(c.isoCode),
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('US'),
              CountryPickerUtils.getCountryByIsoCode('BY'),
            ],
            sortComparator: (Country a, Country b) =>
                a.isoCode.compareTo(b.isoCode),
            onValuePicked: (Country country) {
              countryCodeUpdated(country.isoCode, country.phoneCode);
              print("${country.phoneCode}");
            },
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                height: 1.55,
                fontSize: 14,
              ),
              onChanged: (value) {
                phoneNumberUpdated(value);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: false,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Phone number',
                suffix: GestureDetector(
                  onTap: _canSave
                      ? () => this.onPhoneNumberSubmitted(_currentIsoCode,
                          _currentCountryCode, _currentPhoneNumber)
                      : null,
                  child: Icon(
                    Icons.check,
                    size: 19,
                    color: _canSave
                        ? LiveFeedTheme.theme.highlightColor
                        : Colors.grey,
                  ),
                ),
                errorText: _invalid ? _validationError : null,
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
        ],
      ),
    );
  }
}

class _UpdateProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.grey[800],
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'UPDATE PROFILE',
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
          Transform.rotate(
            angle: pi / 2,
            alignment: Alignment.center,
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          child: GestureDetector(
            onTap: () => context.read<ProfileBloc>().add(LoggedOut()),
            child: Text(
              'Log Out',
              textAlign: TextAlign.center,
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                color: LiveFeedTheme.theme.highlightColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

const List<String> countryCodes = [
  'AF',
  'AX',
  'AL',
  'DZ',
  'AS',
  'AD',
  'AO',
  'AI',
  'AQ',
  'AG',
  'AR',
  'AM',
  'AW',
  'AU',
  'AT',
  'AZ',
  'BS',
  'BH',
  'BD',
  'BB',
  'BY',
  'BE',
  'BZ',
  'BJ',
  'BM',
  'BT',
  'BO',
  'BA',
  'BW',
  'BV',
  'BR',
  'IO',
  'BN',
  'BG',
  'BF',
  'BI',
  'KH',
  'CM',
  'CA',
  'CV',
  'KY',
  'CF',
  'TD',
  'CL',
  'CN',
  'CX',
  'CC',
  'CO',
  'KM',
  'CG',
  'CD',
  'CK',
  'CR',
  'CI',
  'HR',
  'CU',
  'CY',
  'CZ',
  'DK',
  'DJ',
  'DM',
  'DO',
  'EC',
  'EG',
  'SV',
  'GQ',
  'ER',
  'EE',
  'ET',
  'FK',
  'FO',
  'FJ',
  'FI',
  'FR',
  'GF',
  'PF',
  'TF',
  'GA',
  'GM',
  'GE',
  'DE',
  'GH',
  'GI',
  'GR',
  'GL',
  'GD',
  'GP',
  'GU',
  'GT',
  'GG',
  'GN',
  'GW',
  'GY',
  'HT',
  'HM',
  'VA',
  'HN',
  'HK',
  'HU',
  'IS',
  'IN',
  'ID',
  'IR',
  'IQ',
  'IE',
  'IM',
  'IL',
  'IT',
  'JM',
  'JP',
  'JE',
  'JO',
  'KZ',
  'KE',
  'KI',
  'KP',
  'KR',
  'KW',
  'KG',
  'LA',
  'LV',
  'LB',
  'LS',
  'LR',
  'LY',
  'LI',
  'LT',
  'LU',
  'MO',
  'MK',
  'MG',
  'MW',
  'MY',
  'MV',
  'ML',
  'MT',
  'MH',
  'MQ',
  'MR',
  'MU',
  'YT',
  'MX',
  'FM',
  'MD',
  'MC',
  'MN',
  'ME',
  'MS',
  'MA',
  'MZ',
  'MM',
  'NA',
  'NR',
  'NP',
  'NL',
  'AN',
  'NC',
  'NZ',
  'NI',
  'NE',
  'NG',
  'NU',
  'NF',
  'MP',
  'NO',
  'OM',
  'PK',
  'PW',
  'PS',
  'PA',
  'PG',
  'PY',
  'PE',
  'PH',
  'PN',
  'PL',
  'PT',
  'PR',
  'QA',
  'RE',
  'RO',
  'RU',
  'RW',
  'BL',
  'SH',
  'KN',
  'LC',
  'MF',
  'PM',
  'VC',
  'WS',
  'SM',
  'ST',
  'SA',
  'SN',
  'RS',
  'SC',
  'SL',
  'SG',
  'SK',
  'SI',
  'SB',
  'SO',
  'ZA',
  'GS',
  'ES',
  'LK',
  'SD',
  'SR',
  'SJ',
  'SZ',
  'SE',
  'CH',
  'SY',
  'TW',
  'TJ',
  'TZ',
  'TH',
  'TL',
  'TG',
  'TK',
  'TO',
  'TT',
  'TN',
  'TR',
  'TM',
  'TC',
  'TV',
  'UG',
  'UA',
  'AE',
  'GB',
  'US',
  'UM',
  'UY',
  'UZ',
  'VU',
  'VE',
  'VN',
  'VG',
  'VI',
  'WF',
  'EH',
  'YE',
  'ZM',
  'ZW',
];
