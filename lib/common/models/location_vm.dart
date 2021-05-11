import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class LocationVm extends Equatable {
  LocationVm({
    String id,
    this.address,
    this.zipCode,
  }) : _id = id ?? Uuid().v4();

  final String _id;
  final String address;
  final String zipCode;

  String get id => _id;

  @override
  List<Object> get props => [_id, address, zipCode, id];
}
