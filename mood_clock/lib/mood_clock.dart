import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_clock_helper/model.dart';

import 'package:mood_clock/clock_display.dart';
import 'package:mood_clock/mood_background.dart';
import 'package:mood_clock/quote_text.dart';
import 'package:mood_clock/quotes.dart';
import 'package:mood_clock/theme_factory.dart';

///
/// Mood Clock Widget, displays a digital clock with a weather mood
/// background
///
class MoodClock extends StatefulWidget {
  const MoodClock(this.model);

  final ClockModel model;

  @override
  _MoodClockState createState() => _MoodClockState();
}

///
/// State for the mood clock, has the clock timer.
/// Localized based on the language code as fetched from the dart:ui package.
/// As MaterialApp is inside clock_helper which can't be modified, only basic
/// localization right now.
///
class _MoodClockState extends State<MoodClock> {
  // time reference for the clock display.
  DateTime _dateTime = DateTime.now();

  // Timer for updating the clock.
  Timer _timer;

  // Stores the currently display quote, only updates on change of model.
  Quote _currentQuote;

  @override
  void initState() {
    super.initState();

    // initialize i18n
    initializeDateFormatting();

    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(MoodClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  ///
  /// triggers if any changes happen to the model, e.g. weather state, clock
  /// settings.
  ///
  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
      _currentQuote = Quotes().randomQuote(widget.model.weatherString);
    });
  }

  ///
  /// control the timer to update the clock display.
  ///
  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();

      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  ///
  /// build the main canvas to display the clock.
  ///
  @override
  Widget build(BuildContext context) {
    // define default text style to use in clock setup
    final defaultStyle = ThemeFactory.defaultStyle(context);

    // build and return clock display.
    return DefaultTextStyle(
        style: defaultStyle,
        child: Stack(
          children: <Widget>[
            MoodBackground(mood: widget.model.weatherString),
            Positioned(
              top: ThemeFactory.offset(context),
              left: ThemeFactory.offset(context),
              child: ClockDisplay(widget.model.is24HourFormat),
            ),
            Positioned(
                top: ThemeFactory.offset(context),
                right: ThemeFactory.offset(context),
                child: Text.rich(TextSpan(
                    text: _infoText(),
                    style: ThemeFactory.infoTextStyle(context)))),
            Positioned(
              bottom: ThemeFactory.offset(context),
              left: ThemeFactory.offset(context),
              child: QuoteText(_currentQuote),
            ),
            Positioned(
              bottom: ThemeFactory.offset(context),
              right: ThemeFactory.offset(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(widget.model.temperatureString,
                      style: ThemeFactory.infoTextStyle(context)),
                  SizedBox(height: 5),
                  Image(
                      color:
                          ThemeFactory.colors(context)[ColorThemeElement.text],
                      image: _moodIcon()),
                ],
              ),
            )
          ],
        ));
  }

  ///
  /// displays the info text with current date and determines if either am, pm
  /// or nothing needs to be displayed.
  ///
  String _infoText() {
    Locale userLocale =
        Locale(ui.window.locale.languageCode, ui.window.locale.countryCode);
    final amPm =
        (widget.model.is24HourFormat ? "" : _dateTime.hour >= 12 ? "pm" : "am");

    return "${DateFormat.MMMEd(userLocale.languageCode).format(_dateTime)}"
        "\n$amPm";
  }

  ///
  /// get mood image based on chosen weather conditions aka 'mood'
  ///
  AssetImage _moodIcon() {
    return AssetImage("assets/${widget.model.weatherString}-icon.png");
  }
}
