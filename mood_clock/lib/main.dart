import 'dart:io';

import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'mood_clock.dart';

///
/// run clock widget using the ClockCustomizer frame from the flutter clock helper
/// Localized based on the language code as fetched from the dart:ui package.
/// As MaterialApp is inside clock_helper which can't be modified, only basic
/// localization right now.
///
void main() {
  // A temporary measure until Platform supports web and TargetPlatform supports
  // macOS.
  if (!kIsWeb && Platform.isMacOS) {
    // TODO(gspencergoog): Update this when TargetPlatform includes macOS.
    // https://github.com/flutter/flutter/issues/31366
    // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override.
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  // The [ClockCustomizer] takes in a [ClockBuilder] that consists of:
  //  - A clock widget (in this case, [MoodClock])
  //  - A model (provided to you by [ClockModel])
  runApp(ClockCustomizer((ClockModel model) => MoodClock(model)));
}
