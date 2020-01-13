import 'package:flutter/material.dart';

import 'package:mood_clock/quotes.dart';
import 'package:mood_clock/theme_factory.dart';

///
/// displays the passed 'Quote', uses an AnimatedSwitcher for changing the
/// quote with the quote text as value key.
///
class QuoteText extends StatelessWidget {
  final Quote quote;
  QuoteText(this.quote);

  @override
  Widget build(BuildContext context) {
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
            Text(quote.text, style: ThemeFactory.quoteStyle(context)),
            SizedBox(height: 5),
            Text(quote.author, style: ThemeFactory.quoteAuthorStyle(context)),
          ],
        ));
  }
}
