import 'dart:math';
import 'dart:ui' as ui;

///
/// Stores quotes from known people which refer to the weather moods.
/// Supports English and German.
///
class Quotes {
  final quotes = {
    "en": {
      "windy": [
        Quote("\"I cannot command winds and weather.\"", "Horatio Nelson"),
        Quote("\"Climate is what we expect, weather is what we get.\"",
            "Mark Twain"),
      ],
      "rainy": [
        Quote("\"A bank is a place where they lend you an umbrella\n"
            "in fair weather and ask for it back\nwhen it begins to rain.\"",
            "Robert Frost"),
        Quote("\"Climate is what we expect, weather is what we get.\"",
            "Mark Twain"),
        Quote("\"Sometimes I wish that I was the weather,\n"
            "you'd bring me up in conversation forever.\n"
            "And when it rained, I'd be the talk of the day.\"", "John Mayer")
      ],
      "foggy": [
        Quote("\"The weather and my mood have little connection.\n"
            "I have my foggy and my fine days within me;\n"
            "my prosperity or misfortune has little to do with the matter.\"",
            "Blaise Pascal"),
        Quote("\"Climate is what we expect, weather is what we get.\"",
            "Mark Twain"),
      ],
      "thunderstorm": [
        Quote("\"I cannot command winds and weather.\"", "Horatio Nelson"),
        Quote("\"Climate is what we expect, weather is what we get.\"",
            "Mark Twain"),
      ],
      "sunny": [
        Quote("\"I'm leaving because the weather is too good.\n"
                "I hate London when it's not raining.\"",
            "Groucho Marx"),
        Quote("\"I like anywhere with a beach.\n"
            "A beach and warm weather is all I really need.\"",
            "Rob Gronkowsky"),
      ],
      "cloudy": [
        Quote("\"Wherever you go, no matter what the weather,\n"
            "always bring your own sunshine.\"", "Anthony J. D'Angelo"),
      ],
      "snowy": [
        Quote("\"I like the cold weather.\nIt means you get work done.\"",
            "Noam Chomsky"),
        Quote("\"I love cold weather.\"", "Seth Rogen"),
      ]
    },
    "de": {
      "windy": [
        Quote("\"Gegner bedürfen einander oft mehr als Freunde,\n"
            "denn ohne Wind gehen keine Mühlen.\"", "Hermann Hesse"),
        Quote("\"Wenn der Wind des Wandels weht,\nbauen die Einen Schutzmauern,"
            "\ndie Anderen bauen Windmühlen.\"", "Chinesische Weisheit"),
      ],
      "rainy": [
        Quote("\"Der Humor ist der Regenschirm der Weisen.\"", "Erich Kästner"),
        Quote("\"Der Mut ist wie ein Regenschirm.\n"
            "Wenn man ihn am dringendsten braucht, fehlt er einem.\"",
            "Fernandel"),
        Quote("\"Ein Kollege von mir berichtete mir von einem Fernsehstar,\n"
            "dessen Eitelkeit so weit gediehen war, dass er sich sogar zu\n"
            "verbeugen pflegte, wenn der Regen an die Fenster klatschte.\"",
            "Hans-Joachim Kulenkampff"),
      ],
      "foggy": [
        Quote("\"Wahrheit ist eine Fackel, die durch den Nebel leuchtet,\n"
            "ohne ihn zu vertreiben.\"",
            "Claude Adrien Helvetius"),
      ],
      "thunderstorm": [
        Quote("\"Donner ist gut und eindrucksvoll,\n"
            "aber die Arbeit leistet der Blitz.\"", "Mark Twain"),
        Quote("\"Ehen werden im Himmel gemacht heißt es,\n"
            "aber Blitz und Donner auch.\"", "Clint Eastwood"),
      ],
      "sunny": [
        Quote(
            "\"Manche Hähne glauben,\ndass die Sonne ihretwegen aufgeht.\"",
            "Theodor Fontane"),
        Quote("\"Blumen können nicht blühen ohne die Wärme der Sonne.\n"
            "Menschen können nicht Mensch werden.\n"
            "ohne die Wärme der Freundschaft\"", "Phil Bosmans"),
        Quote("\"Was hilft aller Sonnenaufgang,\nwenn wir nicht aufstehen.\"",
            "Georg Christoph Lichtenberg")
      ],
      "cloudy": [
        Quote("\"Ich stehe mit beiden Beinen fest in den Wolken.\"",
            "Hermann Van Veen"),
        Quote("\"Wer Schmetterlinge lachen hört,\n"
            "weiss wie Wolken schmecken.\"", "Novales")
      ],
      "snowy": [
        Quote("\"Die Lüge ist wie ein Schneeball: Je länger man ihn wälzt,\n"
            "desto größer wird er.\"", "Martin Luther"),
        Quote("\"Ein guter Rat ist wie Schnee. Je sanfter er fällt,\n"
            "desto länger bleibt er liegen\n"
            "und um so tiefer dringt er ein.\"", "Simone Signoret"),
      ]
    }
  };

  ///
  /// get a random quote for the given weather mood as retrieved from the
  /// clock model
  ///
  Quote randomQuote(String mood) {
    List quoteList = quotes[ui.window.locale.languageCode][mood];
    int randomQuoteIndex = Random().nextInt(quoteList.length);
    return quoteList[randomQuoteIndex];
  }
}

///
/// a quote consisting of the text (might have line feeds) and
/// the author
///
class Quote {
  final String text;
  final String author;

  Quote(this.text, this.author);
}
