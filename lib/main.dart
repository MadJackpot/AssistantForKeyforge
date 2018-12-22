import 'dart:convert';

import 'package:assistant_for_keyforge/deck.dart';
import 'package:assistant_for_keyforge/deck_list.dart';
import 'package:assistant_for_keyforge/deck_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
    );
  }
}


// Example of API hit: https://www.keyforgegame.com/api/decks/a290b260-34d4-4576-be83-4b739522deb1/?links=cards
class App extends StatefulWidget {
  @override
  AppState createState() {
    return new AppState();
  }
}

class AppState extends State<App> {
  final decks = new List<Deck>();

  AppState() {
    http.get(
      "https://www.keyforgegame.com/api/decks/dd9b6da4-f21f-484c-95f1-82c0d43b26ad/?links=cards")
      .then((response) => setState(() {
        var obj = json.decode(response.body);
        decks.add(Deck.FromJson(obj));
    }));

    http.get(
        "https://www.keyforgegame.com/api/decks/e20ea845-2b5a-415c-be2e-6c07b522f810/?links=cards")
        .then((response) => setState(() {
        var obj = json.decode(response.body);
        decks.add(Deck.FromJson(obj));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deck List"),
        leading: Icon(Icons.wb_sunny),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: decks.isNotEmpty ? DeckList(decks) : Container(),
          )
        ],
      ),
    );
  }
}
