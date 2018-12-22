import 'package:assistant_for_keyforge/card_view.dart';
import 'package:assistant_for_keyforge/keyforge_card.dart';
import 'package:flutter/material.dart';
import 'package:assistant_for_keyforge/deck.dart';

class DeckView extends StatefulWidget {
  final Deck deck;

  DeckView(this.deck);

  @override
  _DeckViewState createState() => _DeckViewState();
}

class _DeckViewState extends State<DeckView> {
  List<KeyforgeCard> cardList;

  @override
  Widget build(BuildContext context) {
    if (cardList == null) {
      cardList = widget.deck.cards;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deck.deckTitle),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Image.network(widget.deck.houses[0].image),
                  onPressed: (){
                    setState((){
                      cardList = widget.deck.getCardsFromHouse(widget.deck.houses[0].name);
                    });
                  },
                ),
                FlatButton(
                  child: Image.network(widget.deck.houses[1].image),
                  onPressed: (){
                    setState((){
                      cardList = widget.deck.getCardsFromHouse(widget.deck.houses[1].name);
                    });
                  },
                ),
                FlatButton(
                  child: Image.network(widget.deck.houses[2].image),
                  onPressed: (){
                    setState((){
                      cardList = widget.deck.getCardsFromHouse(widget.deck.houses[2].name);
                    });
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: cardList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(cardList[index].card_number.toString()),
                  title: Text(cardList[index].card_title),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CardView(cardList[index]),
                    ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
