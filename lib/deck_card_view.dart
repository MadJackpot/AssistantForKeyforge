import 'package:assistant_for_keyforge/keyforge_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DeckCardView extends StatelessWidget {
  final List<KeyforgeCard> cards;

  DeckCardView(this.cards);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards View"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        textTheme: Theme.of(context).textTheme,
      ),
      body: Center(child: CardBlock(cards: cards)),
    );
  }
}

class CardBlock extends StatelessWidget {
  final List<KeyforgeCard> cards;

  const CardBlock({
    Key key,
    this.cards
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: cards.map((c) {
        return new Builder(
          builder: (BuildContext context) {
            return new Image.network(c.front_image);
          },
        );
      }).toList(),
      autoPlay: false,
      height: 0.86 * MediaQuery.of(context).size.height,
      viewportFraction: 0.83,
    );
  }
}


class OldView extends StatelessWidget {
  const OldView({
    Key key,
    @required this.cards,
  }) : super(key: key);

  final List<KeyforgeCard> cards;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cards.length,
      itemBuilder: (context, index) => Image.network(cards[index].front_image),
    );
  }
}
