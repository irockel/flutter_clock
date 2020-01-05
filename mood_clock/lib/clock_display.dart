import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// encapsulates just the time presentation, is stateless and has to
/// be updated from the outside. As a timer is needed for different
/// elements there's no use in having its own.
///
class ClockDisplay extends StatelessWidget {
  final bool is24HourFormat;

  ClockDisplay(this.is24HourFormat);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();

    final hourFontSize = MediaQuery.of(context).size.width / 4;
    final minuteFontSize = MediaQuery.of(context).size.width / 5;

    // Date format for hour, minute and seconds
    final hours = DateFormat(this.is24HourFormat ? 'HH' : 'hh')
        .format(dateTime)
        .split('');
    final minutes = DateFormat('mm').format(dateTime).split('');
    final seconds = DateFormat('ss').format(dateTime).split('');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        ClockDisplayDigit(
            digit: hours[0], style: new TextStyle(fontSize: hourFontSize)),
        ClockDisplayDigit(
            digit: hours[1], style: new TextStyle(fontSize: hourFontSize)),
        SizedBox(width: 30),
        ClockDisplayDigit(
            digit: minutes[0], style: new TextStyle(fontSize: minuteFontSize)),
        ClockDisplayDigit(
            digit: minutes[1], style: new TextStyle(fontSize: minuteFontSize)),
        SizedBox(width: 30),
        ClockDisplayDigit(digit: seconds[0]),
        ClockDisplayDigit(digit: seconds[1]),
      ],
    );
  }
}

///
/// display and animate a clock display digit
///
class ClockDisplayDigit extends StatelessWidget {
  final String digit;
  final TextStyle style;

  ///
  /// provide digit and optionally style to display
  ///
  ClockDisplayDigit({this.digit, this.style});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInCirc,
      switchOutCurve: Curves.easeOutCirc,
      child: Text("$digit", style: style, key: ValueKey(digit)),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          child: child,
          scale: animation,
        );
      },
    );
  }
}
