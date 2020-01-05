import 'package:flutter/material.dart';

///
/// controls the mood background based on the passed mood string
/// lays a black colored layer with the given opacity on top of the
/// displayed image.
///
class MoodBackground extends StatefulWidget {
  final String mood;
  final double opacity;

  MoodBackground({this.mood, this.opacity});

  @override
  State<StatefulWidget> createState() => _MoodBackgroundState();
}

class _MoodBackgroundState extends State<MoodBackground> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Container(
        key: ValueKey(widget.mood),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(widget.opacity), BlendMode.darken),
            image: getMoodImage(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  ///
  /// get mood image based on chosen weather conditions aka 'mood'
  ///
  AssetImage getMoodImage() {
    return AssetImage("assets/" + widget.mood + "-mood.jpg");
  }
}
