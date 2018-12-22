import 'package:assistant_for_keyforge/deck.dart';
import 'package:assistant_for_keyforge/deck_view.dart';
import 'package:flutter/material.dart';

class DeckList extends StatefulWidget {
  final List<Deck> startingDeckList;

  DeckList(this.startingDeckList);

  @override
  _DeckListState createState() => _DeckListState();
}

class _DeckListState extends State<DeckList> {
  List<Deck> decks;

  @override
  Widget build(BuildContext context) {
    if (decks == null) {
      decks = widget.startingDeckList;
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: decks.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 90.0,
            height: 50.0,
            child: Row(
              children: <Widget>[
                Image.network(decks[index].houses[0].image, width: 30.0),
                Image.network(decks[index].houses[1].image, width: 30.0),
                Image.network(decks[index].houses[2].image, width: 30.0),
              ],
            ),
          ),
          title: Text(decks[index].deckTitle),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => DeckView(decks[index])
            ));
          },
        );
      },
    );
  }
}
