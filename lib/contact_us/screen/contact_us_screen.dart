import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/common/widgets/livefeed_app_bar.dart';
import 'package:livefeed/contact_us/bloc/contact_us_form_bloc.dart';
import 'package:livefeed/contact_us/models/contact_us_type_field.dart';
import 'package:livefeed/contact_us/screen/contact_us_layout.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_screen.dart';
import 'package:livefeed/marketplace/screens/marketplace_screen.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({
    this.formType,
    this.initialBody,
  });

  final ContactUsType formType;
  final String initialBody;

  static Route route({
    ContactUsType formType,
    String initialBody,
  }) {
    return MaterialPageRoute<void>(
        builder: (_) => ContactUsScreen(
              formType: formType,
              initialBody: initialBody,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = LivefeedAppBar(
      context: context,
      onLogoTapped: () => Navigator.of(context).pop(),
      onHowItWorksTapped: () => Navigator.of(context).pushReplacement(
        HowItWorksScreen.route(
            previousRoute: ContactUsScreen.route(formType: formType)),
      ),
      onMarketplaceTapped: () =>
          Navigator.of(context).pushReplacement(MarketplaceScreen.route(
        previousRoute: ContactUsScreen.route(formType: formType),
      )),
    );
    return Scaffold(
      appBar: appBar.build(),
      body: BlocProvider(
        create: (context) {
          return ContactUsFormBloc(
            initialType: formType,
            initialBody: initialBody,
          );
        },
        child: ContactUsLayout(
          initialBodyText: initialBody != null ? initialBody : null,
        ),
      ),
    );
  }
}
