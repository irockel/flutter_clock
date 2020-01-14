import 'package:flutter/material.dart';

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
  static String _fontFamily = "Poppins";
  // Quote font
  static String _quoteFontFamily = "DancingScript";
  // Font for the quote author
  static String _quoteAuthorFontFamily = "BarlowCondensed";

  ///
  /// Color theme for light setting in clock model
  ///
  static final _lightTheme = {
    ColorThemeElement.background: Color(0xAAAAAAAA),
    ColorThemeElement.text: Color(0xF3F3F3F3),
  };

  ///
  /// Color theme for dark setting in clock model
  ///
  static final _darkTheme = {
    ColorThemeElement.background: Colors.black,
    ColorThemeElement.text: Color(0xC3C3C3C3),
  };

  ///
  /// Colors based on set brightness level.
  ///
  static Map<ColorThemeElement, Color> colors(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
  }

  ///
  /// Default text style to be used in the clock display. The other text style
  /// inherit from this text style and only modify the text size or
  /// in case of the quote part the used font family.
  ///
  static TextStyle defaultStyle(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 16;

    return TextStyle(
      color: colors(context)[ColorThemeElement.text],
      fontFamily: _fontFamily,
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
  /// Offset to be used by positioned widgets based on default font size.
  ///
  static double offset(BuildContext context) {
    return (MediaQuery.of(context).size.width / 16) * 0.7;
  }

  ///
  /// Text style for the hour part of the clock display.
  ///
  static TextStyle hourStyle(BuildContext context) {
    return new TextStyle(fontSize: MediaQuery.of(context).size.width / 4);
  }

  ///
  /// Text style for the minute part of the clock display.
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
  /// Text style for the quote text. Did not use google_fonts plugin
  /// here to avoid any network request to be performed.
  ///
  static TextStyle quoteStyle(BuildContext context) {
    return new TextStyle(
        fontFamily: _quoteFontFamily,
        fontWeight: FontWeight.normal,
        fontSize: MediaQuery.of(context).size.width / 31);
  }

  ///
  /// Text style for the author part of a quote. Did not use google_fonts
  /// plugin here to avoid any network request to be performed.
  ///
  static TextStyle quoteAuthorStyle(BuildContext context) {
    return new TextStyle(
        fontFamily: _quoteAuthorFontFamily,
        fontWeight: FontWeight.normal,
        fontSize: MediaQuery.of(context).size.width / 31);
  }
}
