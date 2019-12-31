import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  String fontFamily = "Poppins";
  Locale currentLocale;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    currentLocale = Localizations.localeOf(context);
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

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

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

    // Date format for hour, minute and seconds
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final second = DateFormat('ss').format(_dateTime);

    // font size for the elements. Calculated based on screen width
    final hourFontSize = MediaQuery.of(context).size.width / 4;
    final minuteFontSize = MediaQuery.of(context).size.width / 5;
    final infoFontSize = MediaQuery.of(context).size.width / 24;
    final fontSize = MediaQuery.of(context).size.width / 16;

    // offset of elements to margin based on font size
    final offset = fontSize * 0.7;

    // define default text style to use in clock setup
    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );

    // build and return clock display.
    return DefaultTextStyle(
        style: defaultStyle,
        child: Stack(
          children: <Widget>[
            Container(
              //color: colors[_Element.background],
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(opacity), BlendMode.darken),
                  image: getMoodImage(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: offset,
              left: offset,
              child: Text.rich(TextSpan(
                children: [
                  TextSpan(
                      text: hour + " ",
                      style: TextStyle(fontSize: hourFontSize)),
                  TextSpan(
                      text: minute + " ",
                      style: TextStyle(fontSize: minuteFontSize)),
                  TextSpan(text: second),
                ],
              )),
            ),
            Positioned(
                top: offset,
                right: offset,
                child: Text.rich(TextSpan(
                    text: getDateInfo() + getAmPm(),
                    style: TextStyle(
                        fontSize: infoFontSize,
                        fontWeight: FontWeight.normal)))),
            Positioned(
                bottom: offset,
                left: offset,
                child: Text.rich(TextSpan(
                    text: widget.model.temperatureString +
                        "\n" +
                        widget.model.location,
                    style: TextStyle(
                        fontSize: infoFontSize,
                        fontWeight: FontWeight.normal)))),
            Positioned(
              bottom: offset,
              right: offset,
              child: Image(
                  color: colors[_Element.text],
                  image: getMoodIcon()
              ),
            )
          ],
        ));
  }

  ///
  /// format date info string, which is displayed at top.
  ///
  String getDateInfo() {
    return DateFormat("MMMEd").format(_dateTime);
  }

  ///
  /// determine if either am, pm or nothing needs to be displayed
  ///
  String getAmPm() {
    return (widget.model.is24HourFormat
        ? ""
        : _dateTime.hour >= 12 ? "\npm" : "\nam");
  }

  ///
  /// get mood image based on chosen weather conditions aka 'mood'
  ///
  AssetImage getMoodImage() {
    return AssetImage("assets/" + widget.model.weatherString + "-mood.jpg");
  }

  ///
  /// get mood image based on chosen weather conditions aka 'mood'
  ///
  AssetImage getMoodIcon() {
    return AssetImage("assets/" + widget.model.weatherString + "-icon.png");
  }
}
