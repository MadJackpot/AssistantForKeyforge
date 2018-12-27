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
  int _currentSelectionIndex;

  @override
  Widget build(BuildContext context) {
    if (cardList == null) {
      cardList = widget.deck.getCardsFromHouse(widget.deck.houses[0].name);
      _currentSelectionIndex = 0;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        textTheme: Theme.of(context).textTheme,
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
                      _currentSelectionIndex = 0;
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
                      _currentSelectionIndex = 1;
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
                      _currentSelectionIndex = 2;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 50.0,
            child: Center(
              child: Text("Cards for ${widget.deck.houses[_currentSelectionIndex].name}", style: TextStyle(fontSize: 20.0)),
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

/*
class _HouseButton extends StatelessWidget {
  final Deck _deck;
  final int _houseIndex;
  final _DeckViewState otherWidget;

  _HouseButton(this._deck, this._houseIndex, this.otherWidget);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Hero(
        tag: "hero-${_deck.deckTitle}-${_deck.houses[_houseIndex].name}",
        child: Image.network(_deck.houses[_houseIndex].image),
      ),
      onPressed: (){ otherWidget.setState(() => otherWidget.cardList = _deck.getCardsFromHouse(_deck.houses[_houseIndex].name)); },
    );
  }
}
*/
