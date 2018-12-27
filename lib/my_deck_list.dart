import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:assistant_for_keyforge/deck.dart';
import 'package:assistant_for_keyforge/deck_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyDeckList extends StatefulWidget {
  @override
  _MyDeckListState createState() => _MyDeckListState();
}

class _MyDeckListState extends State<MyDeckList> {
  var decks = new List<Deck>();
  var oldImageList = new List<String>();
  var newImageList = new List<String>();
  Timer _timer;
  var _firstPass = true;

  @override
  Widget build(BuildContext context) {
    if (decks.isEmpty) {
      _addMoreDecks();
      oldImageList = _getRandomizedImageList(decks);
      newImageList = _getRandomizedImageList(decks);
    }

    if (_timer == null) {
      _timer = new Timer.periodic(Duration(seconds: 10), (t) {
        setState((){
          _firstPass = false;
          oldImageList = newImageList;
          newImageList = _getRandomizedImageList(decks);
        });
      });
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: decks.length,
      itemBuilder: (context, index) {
        return Container(
          width: 90.0,
          height: 120.0,
          child: GestureDetector(
            onTap: () =>
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DeckView(decks[index])
            )),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 90.0,
                      height: 70.0,
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
                  ),
                  Expanded(
                    child: Text(decks[index].deckTitle, style: Theme.of(context).textTheme.body1,),
                  ),
                  Container(
                    child: _AnimatedCardBox(decks[index]),
                    width: 80.0,
                    height: double.maxFinite,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addMoreDecks() async {
    var firstDeck = await http.get("https://www.keyforgegame.com/api/decks/e20ea845-2b5a-415c-be2e-6c07b522f810/?links=cards");
    setState(() {
      var obj = json.decode(utf8.decode(firstDeck.bodyBytes));
      decks.add(Deck.fromJson(obj["_linked"], obj["data"]));
    });

    var secondDeck = await http.get("https://www.keyforgegame.com/api/decks/dd9b6da4-f21f-484c-95f1-82c0d43b26ad/?links=cards");
    setState(() {
      var obj = json.decode(utf8.decode(secondDeck.bodyBytes));
      decks.add(Deck.fromJson(obj["_linked"], obj["data"]));
    });
  }
}

class CardPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

String _randomImage(Deck deck) {
  var r = new Random();
  var index = r.nextInt(35);
  return deck.cards[index].front_image;
}

List<String> _getRandomizedImageList(List<Deck> decks) {
  var randomImageList = new List<String>();
  var r = Random();
  for (var deck in decks) {
    var maxCardNum = deck.cards.length - 1;
    var index = r.nextInt(maxCardNum);

    randomImageList.add(deck.cards[index].front_image);
  }

  return randomImageList;
}

class _AnimatedCardBox extends StatefulWidget {
  final Deck deck;

  _AnimatedCardBox(this.deck);

  @override
  __AnimatedCardBoxState createState() => __AnimatedCardBoxState();
}

class __AnimatedCardBoxState extends State<_AnimatedCardBox> {
  Widget firstImage;
  Widget secondImage;
  bool showFirstImage = true;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    if (firstImage == null)
      firstImage = FadeInImage(
        image: NetworkImage(_randomImage(widget.deck)),
        placeholder: AssetImage("assets/loading.gif"),
        //Image.network(_randomImage(widget.deck), fit: BoxFit.fill,)
      );
    if (secondImage == null)
      secondImage = Image.network(_randomImage(widget.deck));

    if (timer == null)
      timer = Timer.periodic(Duration(seconds: 13), (t) async {
        setState(() => showFirstImage = !showFirstImage);

        Future.delayed(Duration(seconds: 5), () {
          if (showFirstImage)
            secondImage = Image.network(_randomImage(widget.deck));
          else
            firstImage = Image.network(_randomImage(widget.deck));
        });
      });

    return AnimatedCrossFade(
      duration: Duration(seconds: 1),
      firstChild: firstImage,
      secondChild: secondImage,
      crossFadeState: showFirstImage ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
