import 'package:assistant_for_keyforge/full_card_view.dart';
import 'package:assistant_for_keyforge/keyforge_card.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final KeyforgeCard card;

  CardView(this.card);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.card_title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        textTheme: Theme.of(context).textTheme,
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                new DetailsBox(details: [
                  Text("Card Type: ${card.card_type}"),
                  Text("House: ${card.house}"),
                  Text(card.traits != null ? "Traits: ${card.traits}" : ""),
                ]),
                DetailsBox(details: [
                  Text("Card Text:"),
                  Text(card.card_text,),
                ]),
              ]
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Type: ${card.card_type}", style: Theme.of(context).textTheme.display1,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Card Text: \n${card.card_text}", style: Theme.of(context).textTheme.display1,),
          ),
          */
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Hero(
                tag: card.front_image,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => FullCardView(card.front_image))
                  ),
                  child: Image.network(card.front_image),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsBox extends StatelessWidget {
  const DetailsBox({
    Key key,
    @required this.details,
  }) : super(key: key);

  final List<Widget> details;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(8.0, 8.0),
                blurRadius: 10.0
              ),
            ]
          ),
          child: Padding(
            padding: EdgeInsets.all(9.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: details,
            ),
          ),
        ),
      ),
    );
  }
}

