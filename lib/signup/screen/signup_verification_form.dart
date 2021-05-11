import 'dart:async';

import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/common/models/verification_code_form_field.dart';
import 'package:livefeed/signup/bloc/signup/signup_bloc.dart';
import 'package:livefeed/theme.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:formz/formz.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SignupVerificationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Verification',
                style: LiveFeedTheme.theme.textTheme.headline1,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 9),
          child: _UserNumberParagraph(),
          // child: FittedBox(child: _UserNumberParagraph()),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: _VerificationInput(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: _SubmitButton(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: _ResendVerificationCodeTemplate(),
        ),
      ],
    );
  }
}

class _UserNumberParagraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        //var country = Country(isoCode: state.phoneIsoCode);
        var country =
            CountryPickerUtils.getCountryByIsoCode(state.phoneIsoCode);
        return FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'One-time password has been sent to:',
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      color: Color.fromRGBO(150, 150, 150, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.58,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CountryPickerUtils.getDefaultFlagImage(country),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 3,
                      left: 8,
                      right: 8,
                    ),
                    child: Text(
                      state.phoneNumber == null
                          ? ''
                          : '+(${state.phoneCountryCode}) ${state.phoneNumber.value}',
                      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                        color: Color.fromRGBO(150, 150, 150, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 1.58,
                      ),
                    ),
                  ),
                  _ChangeNumberNavigator(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChangeNumberNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        'Change phone number',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: LiveFeedTheme.theme.highlightColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        context.read<SignupBloc>().add(NumberChangeRequested());
      },
    );
  }
}

class _VerificationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VerificationInputState();
}

class _VerificationInputState extends State<_VerificationInput>
    with CodeAutoFill {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  @override
  void initState() {
    listenForCode();
    // SmsAutoFill().getAppSignature;
    super.initState();
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  @override
  void codeUpdated() {
    _pinPutController.text = code;
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.transparent),
      borderRadius: BorderRadius.circular(2.0),
      color: Colors.grey[100],
    );
  }

  String translateErrorText(VerificationCodeValidationError error) {
    switch (error) {
      case VerificationCodeValidationError.empty:
        return 'Required';
      case VerificationCodeValidationError.invalid:
        return 'Only numbers allowed';
      case VerificationCodeValidationError.tooShort:
        return 'Please enter at least 7 digits';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Theme(
          data: new ThemeData(),
          child: PinPut(
            fieldsCount: 6,
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            eachFieldWidth: 50,
            eachFieldHeight: 60,
            onChanged: (verificationCode) {
              context
                  .read<SignupBloc>()
                  .add(VerificationCodeUpdated(verificationCode));
              if (verificationCode.length >= 6) {
                context.read<SignupBloc>().add(VerificationCodeSubmitted());
              }
            },
            textStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              height: 1.55,
              fontSize: 20,
            ),
            inputDecoration: InputDecoration(
              errorText: state.verificationCode.invalid
                  ? translateErrorText(state.verificationCode.error)
                  : null,
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
            submittedFieldDecoration: _pinPutDecoration.copyWith(),
            selectedFieldDecoration: _pinPutDecoration.copyWith(
              border: Border.all(),
            ),
            followingFieldDecoration: _pinPutDecoration,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) =>
          previous.verificationFormStatus != current.verificationFormStatus ||
          previous.verificationCode != current.verificationCode,
      builder: (context, state) {
        return state.verificationFormStatus.isSubmissionInProgress
            ? Container(
                height: 35,
                width: 35,
                child: const CircularProgressIndicator(),
              ) // Color taken from theme accentColor
            : Container(
                width: double.infinity,
                child: FlatButton(
                  onPressed: state.verificationFormStatus.isValidated
                      ? () {
                          context
                              .read<SignupBloc>()
                              .add(const VerificationCodeSubmitted());
                        }
                      : null,
                  disabledColor: LiveFeedTheme.theme.disabledColor,
                  color: LiveFeedTheme.theme.buttonColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'SUBMIT',
                      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class _ResendVerificationCodeTemplate extends StatelessWidget {
  Widget translateResendButton(BuildContext context, SignupState state) {
    if (state.verificationEvent != null) {
      var requestedOn = state.verificationEvent.requestedOn;
      var timerEndTime = DateTime(
          requestedOn.year,
          requestedOn.month,
          requestedOn.day,
          requestedOn.hour,
          requestedOn.minute,
          requestedOn.second + state.verificationEvent.throttleDurationSeconds);

      if (DateTime.now().isAfter(timerEndTime)) {
        return _ResendButtonActive();
      } else {
        return _ResendButtonWithCountdown(
          // NOTE: Adding extra 2 seconds to address the bug with timer restarting on its own the first time
          duration: Duration(
              seconds: timerEndTime.difference(requestedOn).inSeconds + 2),
        );
      }
    } else
      return Text('Verification event doesn\'t exist');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) =>
          previous.verificationEvent != current.verificationEvent,
      builder: (context, state) {
        return translateResendButton(context, state);
      },
    );
  }
}

class _ResendButtonActive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        'Resend one-time password',
        textAlign: TextAlign.center,
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: LiveFeedTheme.theme.highlightColor,
        ),
      ),
      onPressed: () {
        context.read<SignupBloc>().add(NewVerificationCodeRequested());
        SmsAutoFill().listenForCode;
      },
    );
  }
}

class _ResendButtonWithCountdown extends StatefulWidget {
  final Duration duration;

  _ResendButtonWithCountdown({
    this.duration,
  });

  @override
  State<StatefulWidget> createState() =>
      _ResendButtonWithCountdownState(duration);
}

class _ResendButtonWithCountdownState
    extends State<_ResendButtonWithCountdown> {
  _ResendButtonWithCountdownState(this.duration);

  static String formatDuration(Duration d) =>
      '${'${d.inMinutes}'.padLeft(2, '0')}:'
      '${'${d.inSeconds % 60}'.padLeft(2, '0')}';
  final Duration duration;

  /// When the running timer will hit zero.
  DateTime endTime;

  /// A timer that periodically fires to update the UI.
  Timer timer;

  Duration remainingTime;

  /// How long until the next tick should fire, i.e. the next time the seconds
  /// remaining will change.
  Duration get nextTick =>
      remainingTime - Duration(seconds: remainingTime.inSeconds);

  bool running = false;

  /// Updates the UI and schedules the next tick.
  void tick() {
    setState(() {});
    remainingTime = endTime.difference(DateTime.now());
    if (remainingTime > Duration.zero) {
      timer = Timer(nextTick, tick);
    } else {
      // Countdown is finished!
      stopCountdown();
    }
  }

  /// Starts [timer], if not running already.
  void startTimer() {
    if (timer != null || !running) return;
    tick();
  }

  /// Stops [timer], if not stopped already.
  void stopTimer() {
    if (timer == null) return;
    timer.cancel();
    timer = null;
  }

  /// Starts the countdown
  void startCountdown() {
    running = true;
    endTime = DateTime.now().add(duration);
    startTimer();
  }

  /// Stops the countdown
  void stopCountdown() {
    running = false;
    stopTimer();
    remainingTime = duration;
    setState(() {});
  }

  @override
  void initState() {
    startCountdown();
    return super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (running) {
      return FlatButton(
        minWidth: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'Resend one-time password in ${formatDuration(remainingTime ?? duration)}',
          textAlign: TextAlign.center,
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            color: LiveFeedTheme.theme.highlightColor,
          ),
        ),
        onPressed: null,
      );
    } else {
      return _ResendVerificationCodeTemplate();
    }
  }
}
