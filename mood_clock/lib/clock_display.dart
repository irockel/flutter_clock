import 'package:flutter/cupertino.dart';
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
    final hour = DateFormat(this.is24HourFormat ? 'HH' : 'hh').format(dateTime);
    final minute = DateFormat('mm').format(dateTime);
    final second = dateTime.second; //DateFormat('ss').format(dateTime);
    final showFirst = dateTime.second % 2 == 0;
    final oldSecond = second -1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text(hour + " ",
            style: TextStyle(fontSize: hourFontSize),
            ),
        Text(minute + " ",
            style: TextStyle(fontSize: minuteFontSize),
            ),
        AnimatedCrossFade(duration: const Duration(seconds: 1),
          firstChild: showFirst ? Text("$second") : Text("$oldSecond"),
          secondChild: showFirst ? Text("$oldSecond") : Text("$second"),
          crossFadeState: showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstCurve: Curves.easeInOut,
          secondCurve: Curves.easeInOut,),

      ],
    );
  }

}