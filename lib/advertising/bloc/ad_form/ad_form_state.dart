part of 'ad_form_bloc.dart';

class AdFormState extends Equatable {
  const AdFormState({
    this.targetMarket = TargetMarket.worldwide,
    this.targetView = TargetView.timeline_post,
    this.createDesignRequestDescription,
    this.createDesignRequestImagePath,
    this.uploadDesignImagePath,
  });

  final TargetMarket targetMarket;
  final TargetView targetView;
  final String createDesignRequestDescription;
  final String createDesignRequestImagePath;
  final String uploadDesignImagePath;

  AdFormState copyWith({
    TargetMarket targetMarket,
    TargetView targetView,
    String createDesignRequestDescription,
    String createDesignRequestImagePath,
    String uploadDesignImagePath,
  }) {
    return AdFormState(
      targetMarket: targetMarket ?? this.targetMarket,
      targetView: targetView ?? this.targetView,
      createDesignRequestDescription:
          createDesignRequestDescription ?? this.createDesignRequestDescription,
      createDesignRequestImagePath:
          createDesignRequestImagePath ?? this.createDesignRequestImagePath,
      uploadDesignImagePath:
          uploadDesignImagePath ?? this.uploadDesignImagePath,
    );
  }

  @override
  List<Object> get props => [
        targetMarket,
        targetView,
        createDesignRequestDescription,
        createDesignRequestImagePath,
        uploadDesignImagePath,
      ];
}
