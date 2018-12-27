import 'dart:convert';

import 'package:assistant_for_keyforge/deck.dart';
import 'package:assistant_for_keyforge/deck_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeckList extends StatefulWidget {
  @override
  _DeckListState createState() => _DeckListState();
}

class _DeckListState extends State<DeckList> {
  var decks = new List<Deck>();
  var _pageCountShown = 0;

  @override
  Widget build(BuildContext context) {
    if (decks.isEmpty)
      _addMoreDecks();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: decks.length + 1,
      itemBuilder: (context, index) {
        return Container(
          color: _getColorOfTile(index),
          child: index == decks.length
          ? GestureDetector(
            child: Container(
              width: 90.0,
              height: 50.0,
              child: Center(child: Text("Load more", textScaleFactor: 1.3,)),
            ),
            onTap: () => _addMoreDecks(),
          )
          : ListTile(
            leading: Container(
              width: 90.0,
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: "hero-${decks[index].deckTitle}-${decks[index].houses[0].name}",
                    child: Image.network(decks[index].houses[0].image, width: 30.0),
                  ),
                  Hero(
                    tag: "hero-${decks[index].deckTitle}-${decks[index].houses[1].name}",
                    child: Image.network(decks[index].houses[1].image, width: 30.0),
                  ),
                  Hero(
                    tag: "hero-${decks[index].deckTitle}-${decks[index].houses[2].name}",
                    child: Image.network(decks[index].houses[2].image, width: 30.0),
                  ),
                ],
              ),
            ),
            title: Text(decks[index].deckTitle, style: Theme.of(context).textTheme.body1,),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DeckView(decks[index])
              ));
            },
          ),
        );
      },
    );
  }

  void _addMoreDecks() async {
    var startingPageCount = _pageCountShown + 1;
    var endPageToShow = startingPageCount + 1;
    for (int i = startingPageCount; i <= endPageToShow; ++i) {
      var response = await http.get("https://www.keyforgegame.com/api/decks/?page=$i&links=cards");
      setState(() {
        var obj = json.decode(utf8.decode(response.bodyBytes));
        for (var deck in obj["data"]) {
          decks.add(Deck.fromJson(obj["_linked"], deck));
        }
      });
    }

    _pageCountShown = endPageToShow;
  }

  Color _getColorOfTile(int index) {
    if (index == decks.length)
      return Colors.blue.shade200;
    else if (index % 2 == 0)
      return Colors.grey.shade300;
    else
      return Colors.grey.shade400;
  }
}
