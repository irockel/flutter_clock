import 'package:flutter/material.dart';

///
/// controls the mood background based on the passed mood string lays a black
/// colored layer with the given opacity on top of the displayed image.
///
class MoodBackground extends StatelessWidget {
  final String mood;

  MoodBackground({this.mood});

  @override
  Widget build(BuildContext context) {
    // image darkener based on chosen brightness.
    final opacity =
        Theme.of(context).brightness == Brightness.light ? 0.3 : 0.6;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Container(
        key: ValueKey(mood),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(opacity), BlendMode.darken),
            image: _moodImage(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  ///
  /// get mood image based on chosen weather conditions aka 'mood'
  ///
  AssetImage _moodImage() {
    return AssetImage("assets/$mood-mood.jpg");
  }
}
