import 'package:equatable/equatable.dart';

enum TargetMarket { worldwide, local, hyperlocal }
enum TargetView { timeline_post, timeline, post }

class CurrentAd extends Equatable {
  final String id;
  final TargetMarket targetMarket;
  final TargetView targetView;
  final String address;
  final String zipCode;
  final bool enabled;
  final String imagePath;
  final bool networkImage;

  CurrentAd({
    this.id,
    this.targetMarket,
    this.targetView,
    this.address,
    this.zipCode,
    this.enabled,
    this.imagePath,
    this.networkImage = false,
  }) : assert(targetMarket != null);

  CurrentAd copyWith({
    String id,
    TargetMarket targetMarket,
    TargetView targetView,
    String address,
    String zipCode,
    bool enabled,
    String imagePath,
    bool networkImage,
  }) {
    return CurrentAd(
      id: id ?? this.id,
      targetMarket: targetMarket ?? this.targetMarket,
      targetView: targetView ?? this.targetView,
      address: address ?? this.address,
      zipCode: zipCode ?? this.zipCode,
      enabled: enabled ?? this.enabled,
      imagePath: imagePath ?? this.imagePath,
      networkImage: networkImage ?? this.networkImage,
    );
  }

  @override
  List<Object> get props => [
        id,
        targetMarket,
        targetView,
        address,
        zipCode,
        enabled,
        imagePath,
        networkImage,
      ];
}
