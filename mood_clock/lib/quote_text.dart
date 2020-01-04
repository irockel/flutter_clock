import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mood_clock/quotes.dart';

class QuoteText extends StatelessWidget {
  final Quote quote;
  final double fontSize;

  QuoteText(this.fontSize, this.quote);

  @override
  Widget build(BuildContext context) {
    TextStyle quoteStyle = GoogleFonts.dancingScript(
        fontSize: MediaQuery.of(context).size.width / 29);
    TextStyle authorStyle = GoogleFonts.barlowCondensed(
        fontSize: MediaQuery.of(context).size.width / 30);

    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            child: child,
            scale: animation,
          );
        },
        child: Column(
          key: ValueKey(quote.text),
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(quote.text, style: quoteStyle),
            SizedBox(height: 5),
            Text(quote.author, style: authorStyle),
          ],
        ));
  }
}
