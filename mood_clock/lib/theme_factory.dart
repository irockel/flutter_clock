import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

///
/// Theme color element
///
enum ColorThemeElement {
  background,
  text,
}

///
/// Service class mainly for text styles and colors to be used by the clock
/// display.
///
/// Calculates font size based on screen geometry, might run into issues on
/// extra wide screens as screen ratio for the clock always is 5:3.
///
class ThemeFactory {
  // Font family used throughout the clock, despite the quote display
  static String fontFamily = "Poppins";

  ///
  /// color theme for light setting in clock model
  ///
  static final _lightTheme = {
    ColorThemeElement.background: Color(0xAAAAAAAA),
    ColorThemeElement.text: Color(0xF3F3F3F3),
  };

  ///
  /// color theme for dark setting in clock model
  ///
  static final _darkTheme = {
    ColorThemeElement.background: Colors.black,
    ColorThemeElement.text: Color(0xC3C3C3C3),
  };

  ///
  /// colors based on set brightness level.
  ///
  static Map<ColorThemeElement, Color> colors(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
  }

  ///
  /// default text style to be used in the clock display. The other text style
  /// inherit from this text style and only modify the text size or
  /// in case of the quote part the used font family.
  ///
  static TextStyle defaultStyle(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 16;

    return TextStyle(
      color: colors(context)[ColorThemeElement.text],
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
  }

  ///
  /// offset to be used by positioned widgets based on default font size.
  ///
  static double offset(BuildContext context) {
    return (MediaQuery.of(context).size.width / 16) * 0.7;
  }

  ///
  /// text style for the hour part of the clock display.
  ///
  static TextStyle hourStyle(BuildContext context) {
    return new TextStyle(fontSize: MediaQuery.of(context).size.width / 4);
  }

  ///
  /// text style for the minute part of the clock display.
  ///
  static TextStyle minuteStyle(BuildContext context) {
    return new TextStyle(fontSize: MediaQuery.of(context).size.width / 5);
  }

  ///
  /// text style for the minute part of the clock display.
  ///
  static TextStyle infoTextStyle(BuildContext context) {
    return new TextStyle(
        fontSize: MediaQuery.of(context).size.width / 27,
        fontWeight: FontWeight.normal);
  }

  ///
  /// text style for the quote text.
  ///
  static TextStyle quoteStyle(BuildContext context) {
    return GoogleFonts.dancingScript(
        fontSize: MediaQuery.of(context).size.width / 31);
  }

  ///
  /// text style for the author part of a quote
  ///
  static TextStyle quoteAuthorStyle(BuildContext context) {
    return GoogleFonts.barlowCondensed(
        fontSize: MediaQuery.of(context).size.width / 31);
  }
}
