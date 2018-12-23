import 'package:assistant_for_keyforge/card_view.dart';
import 'package:assistant_for_keyforge/house.dart';
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
      cardList = widget.deck.getCardsFromHouse(widget.deck.houses[0].name);
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
                  child: Hero(
                    tag: "hero-${widget.deck.deckTitle}-${widget.deck.houses[0].name}",
                    child: Image.network(widget.deck.houses[0].image),
                  ),
                  onPressed: (){
                    setState((){
                      cardList = widget.deck.getCardsFromHouse(widget.deck.houses[0].name);
                    });
                  },
                ),
                FlatButton(
                  child: Hero(
                    tag: "hero-${widget.deck.deckTitle}-${widget.deck.houses[1].name}",
                    child: Image.network(widget.deck.houses[1].image),
                  ),
                  onPressed: (){
                    setState((){
                      cardList = widget.deck.getCardsFromHouse(widget.deck.houses[1].name);
                    });
                  },
                ),
                FlatButton(
                  child: Hero(
                    tag: "hero-${widget.deck.deckTitle}-${widget.deck.houses[2].name}",
                    child: Image.network(widget.deck.houses[2].image),
                  ),
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
                return Container(
                  color: index % 2 == 0 ? Colors.grey.shade300 : Colors.grey.shade400,
                  child: ListTile(
                    leading: Container(
                      width: 80.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(cardList[index].card_number.toString()),
                          _getRarityImage(cardList[index]),
                        ],
                      ),
                    ),
                    title: Text(cardList[index].card_title),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CardView(cardList[index]),
                      ));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


Image _getRarityImage(KeyforgeCard card) {
  String asset;
  double scale = 0.0;
  switch(card.rarity) {
    case "Common":
      asset = "assets/circle.png";
      scale = 9.0;
      break;
    case "Uncommon":
      asset = "assets/rhombus.png";
      scale = 9.0;
      break;
    case "Rare":
      asset = "assets/star.png";
      scale = 8.0;
      break;
    default:
      throw Exception("Something went horribly wrong...");
  }

  return Image.asset(asset, scale: scale);
}

class _houseButton extends StatelessWidget {
  final Deck _deck;
  final int _house_index;
  final Function setstate;

  _houseButton(this._deck, this._house_index, this.setstate);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Hero(
        tag: "hero-${_deck.deckTitle}-${_deck.houses[0].name}",
        child: Image.network(_deck.houses[0].image),
      ),
      onPressed: (){ setstate(); },
    );
  }
}
