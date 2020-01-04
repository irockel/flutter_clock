import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:ui' as ui;

import 'package:mood_clock/clock_display.dart';
import 'package:mood_clock/mood_background.dart';
import 'package:mood_clock/quote_text.dart';
import 'package:mood_clock/quotes.dart';

///
/// Theme color element
///
enum _Element {
  background,
  text,
}

///
/// color theme for light setting in clock model
///
final _lightTheme = {
  _Element.background: Color(0xAAAAAAAA),
  _Element.text: Color(0xF3F3F3F3),
};

///
/// color theme for dark setting in clock model
///
final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Color(0xC3C3C3C3),
};

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
///
class _MoodClockState extends State<MoodClock> {
  // time reference for the clock display.
  DateTime _dateTime = DateTime.now();

  // Timer for updating the clock
  Timer _timer;

  // Font family used throughout the clock, despite the quote display
  String fontFamily = "Poppins";

  // date format for the date info panel, which uses a localized
  // date display.
  DateFormat dateInfoFormat;

  // stores determined user locale.
  Locale userLocale;

  // Stores the currently display quote, only updates on change of model
  Quote currentQuote;

  @override
  void initState() {
    super.initState();

    // initialize i18n
    initializeDateFormatting();
    initUserLocale();

    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  void initUserLocale() {
    // workaround as proper init of i18n happens in MaterialApp which is
    // hidden in flutter_clock_helper
    userLocale = Locale(ui.window.locale.languageCode, ui.window.locale.countryCode);
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
  /// triggers if any changes happen to the model, e.g. weather state, clock settings.
  ///
  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
      currentQuote = Quotes().randomQuote(widget.model.weatherString);
    });
  }

  ///
  /// control the timer to update the clock display
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
    // set color scheme based on chosen brightness
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    // image darkener based on chosen brightness.
    final opacity =
        Theme.of(context).brightness == Brightness.light ? 0.3 : 0.6;

    // font size for the elements. Calculated based on screen width
    final infoFontSize = MediaQuery.of(context).size.width / 27;
    final fontSize = MediaQuery.of(context).size.width / 16;

    // offset of elements to margin based on font size
    final offset = fontSize * 0.7;

    // define default text style to use in clock setup
    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 1.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ],
    );

    // build and return clock display.
    return DefaultTextStyle(
        style: defaultStyle,
        child: Stack(
          children: <Widget>[
            MoodBackground(mood: widget.model.weatherString, opacity: opacity),
            Positioned(
              top: offset,
              left: offset,
              child: ClockDisplay(widget.model.is24HourFormat),
            ),
            Positioned(
                top: offset,
                right: offset,
                child: Text.rich(TextSpan(
                    text: "${DateFormat.MMMEd(userLocale.languageCode).format(_dateTime)}\n${getAmPm()}",
                    style: TextStyle(
                        fontSize: infoFontSize,
                        fontWeight: FontWeight.normal)))),
            Positioned(
                bottom: offset,
                left: offset,
                child: QuoteText(infoFontSize, currentQuote),//QuoteWidget(mood: widget.model.weatherString),
            ),
            Positioned(
              bottom: offset,
              right: offset,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(widget.model.temperatureString, style: TextStyle(
                      fontSize: infoFontSize,
                      fontWeight: FontWeight.normal)),
                  SizedBox(height: 5),
                  Image(
                      color: colors[_Element.text],
                      image: getMoodIcon()
                  ),
                ],
              ),
            )
          ],
        ));
  }

  ///
  /// determine if either am, pm or nothing needs to be displayed
  ///
  String getAmPm() {
    return (widget.model.is24HourFormat
        ? ""
        : _dateTime.hour >= 12 ? "pm" : "am");
  }

  ///
  /// get mood image based on chosen weather conditions aka 'mood'
  ///
  AssetImage getMoodIcon() {
    return AssetImage("assets/" + widget.model.weatherString + "-icon.png");
  }
}
