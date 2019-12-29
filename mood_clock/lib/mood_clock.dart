import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
  shadow,
}

///
/// theme for light setting in clock model
///
final _lightTheme = {
  _Element.background: Color(0xAAAAAAAA),
  _Element.text: Color(0xF3F3F3F3),
};

///
/// theme for dark setting in clock model
///
final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Color(0xF3F3F3F3),
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

  @override
  void initState() {
    super.initState();
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

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      // _timer = Timer(
      //   Duration(minutes: 1) -
      //      Duration(seconds: _dateTime.second) -
      //       Duration(milliseconds: _dateTime.millisecond),
      //  _updateTime,
      // );

      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
         Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
         _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final second = DateFormat('ss').format(_dateTime);
    final hourFontSize = MediaQuery.of(context).size.width / 4;
    final minuteFontSize = MediaQuery.of(context).size.width / 6;
    final fontSize = MediaQuery.of(context).size.width / 8;
    final fontFamily = "Poppins";

    final offset = fontSize * 0.7;
    final hourBlock = fontSize * 1.75;
    final minuteBlock = fontSize * 1.75;

    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: fontFamily,
      fontSize: fontSize,
    );

    final hourStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: fontFamily,
      fontSize: hourFontSize,
    );

    final minuteStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: fontFamily,
      fontSize: minuteFontSize,
    );
    return Container(
      color: colors[_Element.background],
      child: Center(
        child: DefaultTextStyle(
          style: defaultStyle,
          child: Stack(
            children: <Widget>[
              Positioned(left: offset, bottom: 100, child: Text(hour, style: hourStyle)),
              Positioned(left: offset + hourBlock, bottom: 100, child: Text(minute, style: minuteStyle)),
              Positioned(left: offset + hourBlock + minuteBlock, bottom: 100, child: Text(second)),
            ],
          ),
        ),
      ),
    );
  }
}
