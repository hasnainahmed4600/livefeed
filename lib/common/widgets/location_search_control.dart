import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:livefeed/common/widgets/ensure_visible.dart';
import 'package:livefeed/theme.dart';

class BorderedLocationSearchControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: Colors.white,
      ),
      child: LocationSearchControl(),
    );
  }
}

class LocationSearchControl extends StatefulWidget {
  LocationSearchControl({
    this.hintText = 'Search by location',
    this.onAddressUpdated,
  });

  final String hintText;
  final Function(String address, String zipCode) onAddressUpdated;

  @override
  State<StatefulWidget> createState() => _LocationSearchControlState(
        hintText: hintText,
        onAddressUpdated: onAddressUpdated,
      );
}

class _LocationSearchControlState extends State<LocationSearchControl> {
  _LocationSearchControlState({
    this.hintText = 'Search by location',
    this.onAddressUpdated,
  });

  bool _editing = false;
  bool _filtered = false;
  String currentAddress = '';
  String currentZipCode = '';
  final String hintText;
  final Function(String address, String zipCode) onAddressUpdated;

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      return _AddressSearchControl(
        currentAddress,
        currentZipCode,
        (zip, address) {
          setState(
            () {
              currentAddress = onAddressUpdated == null ? address : '';
              currentZipCode = onAddressUpdated == null ? zip : '';
              _editing = false;
              _filtered = onAddressUpdated == null ? true : false;
            },
          );
          if (onAddressUpdated != null) {
            onAddressUpdated(address, zip);
          }
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
        _filtered,
        hintText,
        () {
          setState(
            () {
              _editing = true;
            },
          );
        },
        () {
          setState(() {
            currentAddress = '';
            currentZipCode = '';
            _filtered = false;
            _editing = false;
          });
        },
      );
    }
  }
}

class _AddressDisplay extends StatelessWidget {
  final String address;
  final String zipCode;
  final bool filtered;
  final String hintText;
  final Function onEditTapped;
  final Function onClearTapped;

  _AddressDisplay(
    this.address,
    this.zipCode,
    this.filtered,
    this.hintText,
    this.onEditTapped,
    this.onClearTapped,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: ListTile(
        onTap: filtered ? null : this.onEditTapped,
        leading: Icon(
          Icons.location_pin,
          color: LiveFeedTheme.theme.highlightColor,
        ),
        title: Text(
          filtered ? '$address $zipCode' : hintText,
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w500,
            color: filtered ? Colors.black : Colors.grey,
          ),
        ),
        trailing: filtered
            ? GestureDetector(
                onTap: filtered ? this.onClearTapped : null,
                child: Text(
                  filtered ? 'Clear' : 'Edit',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : null,
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
  bool _determiningPosition = false;

  FocusNode _addressFocusNode = new FocusNode();
  FocusNode _zipFocusNode = new FocusNode();
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
          if (/* key.toLowerCase().contains(_currentZipCode.toLowerCase()) && */
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

  Future<void> _determinePosition() async {
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

    setState(() {
      _determiningPosition = true;
    });

    var position = await Geolocator.getCurrentPosition();

    try {
      List<Placemark> p =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = p[0];
      print(place);

      setState(() {
        _currentAddress = "${place.locality}, ${place.administrativeArea}";
        _currentZipCode = place.postalCode;
        onAddressSelected(_currentZipCode, _currentAddress);
        _determiningPosition = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _determiningPosition = false;
      });
    }
  }

  Widget _buildAddressInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Flex(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 2,
            // width: 160,
            child: EnsureVisibleWhenFocused(
              focusNode: _addressFocusNode,
              child: TextField(
                controller: _addressTextController,
                focusNode: _addressFocusNode,
                onChanged: (value) => updateAddress(value),
                enabled: !_determiningPosition,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  height: 1.55,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Expanded(
            // width: 120,
            flex: 1,
            child: EnsureVisibleWhenFocused(
              focusNode: _zipFocusNode,
              child: TextField(
                controller: _zipTextController,
                focusNode: _zipFocusNode,
                enabled: !_determiningPosition,
                onChanged: (value) => updateZipCode(value),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  height: 1.55,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
          ),
          GestureDetector(
            onTap: _determiningPosition ? null : this.onEditCancelled,
            child: Icon(
              Icons.close,
              color: _determiningPosition ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mainColumn = Column(
      children: [
        _buildAddressInput(),
        const Padding(padding: EdgeInsets.only(top: 5)),
        if (_determiningPosition)
          CircularProgressIndicator.adaptive()
        else
          GestureDetector(
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
      ],
    );
    if (_searching) {
      mainColumn.children.add(_AddressSearchResults(
        _addressSearchResults,
        this.onAddressSelected,
      ));
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: mainColumn,
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
          onTap: () {
            if (this.onAddressSelected != null) {
              this.onAddressSelected(key, value);
            }
          },
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
          horizontal: 0,
        ),
        child: mainColumn,
      );
    } else {
      return Text('No search results');
    }
  }
}
