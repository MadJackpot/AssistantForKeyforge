import 'package:assistant_for_keyforge/deck.dart';
import 'package:assistant_for_keyforge/deck_list.dart';
import 'package:assistant_for_keyforge/my_deck_list.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

void main() async => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
      theme: ThemeData(
        colorScheme: ColorScheme(
          error: Colors.red.shade700,
          primary: Colors.redAccent,
          secondary: Colors.yellow.shade700,
          onSecondary: Colors.red.shade200,
          surface: Colors.red.shade200,
          onError: Colors.red.shade200,
          onBackground: Colors.red.shade200,
          onPrimary: Colors.red.shade200,
          background: Colors.red.shade200,
          secondaryVariant: Colors.red.shade200,
          brightness: Brightness.dark,
          onSurface: Colors.red.shade200,
          primaryVariant: Colors.red.shade200,
        ),
        fontFamily: "Impact",
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, fontFamily: 'Impact'),
          title: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, fontFamily: 'Impact', color: Colors.yellow.shade400),
          display1: TextStyle(fontSize: 16.0, fontFamily: 'Impact', color: Colors.yellow.shade400),
        ),
      ),
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

  bool showMyDecks = false;

  AppState() {
    /*for (int i = 1; i < 36146; ++i) {
      http.get(
          "https://www.keyforgegame.com/api/decks/?page=$i&links=cards")
          .then((response) => setState(() {
        var obj = json.decode(response.body);
        for (var deck in obj["data"]) {
          decks.add(Deck.FromJson(obj["_linked"], deck));
        }
      }));
    }
      */
    /*
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
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0), // Remove the padding for ListView.
          children: <Widget>[
            DrawerHeader(
              child: Text("KeyForge Assistant"),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            ),
            ListTile(
              title: Text("All Decks"),
              onTap: () => setState(() {
                showMyDecks = false;
                Navigator.pop(context);
              }),
            ),
            ListTile(
              title: Text("My Decks"),
              onTap: () => setState(() {
                showMyDecks = true;
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Deck List"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        textTheme: Theme.of(context).textTheme,
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.image),
            onPressed: () async {
              await QRCodeReader()
                .setAutoFocusIntervalInMs(200)
                .setForceAutoFocus(true)
                .scan();
            },
          ),
        ],
      ),
      body: showMyDecks ? MyDeckList() : DeckList(),
    );
  }
}
