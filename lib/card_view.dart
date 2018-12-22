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
      ),
      body: Center(
       child: Image.network(card.front_image),
      )
    );
  }
}

