import 'dart:math';

import 'package:equatable/equatable.dart';

class VerificationEventEntity extends Equatable {
  final String id;
  final DateTime requestedOn;
  final int throttleDurationSeconds;

  VerificationEventEntity({
    this.id,
    this.requestedOn,
    this.throttleDurationSeconds,
  });

  VerificationEventEntity copyWith({
    String id,
    DateTime requestedOn,
    int throttleDurationSeconds,
  }) {
    return VerificationEventEntity(
      id: id ?? this.id,
      requestedOn: requestedOn ?? this.requestedOn,
      throttleDurationSeconds:
          throttleDurationSeconds ?? this.throttleDurationSeconds,
    );
  }

  @override
  List<Object> get props => [id, requestedOn, throttleDurationSeconds];

  @override
  String toString() {
    return 'VerificationEventEntity {id: $id, requestedOn: $requestedOn, throttleDurationSeconds: $throttleDurationSeconds}';
  }
}
