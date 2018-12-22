import 'package:assistant_for_keyforge/house.dart';
import 'package:assistant_for_keyforge/keyforge_card.dart';

class Deck {
  String deckTitle;
  final houses = new List<House>();
  final cards = new List<KeyforgeCard>();

  Deck.FromJson(Map<String, dynamic> json) {
    var moreJson = json['_linked']['houses'];
    for (var house in moreJson) {
      var newHouse = House.FromJson(house);
      houses.add(newHouse);
    }

    var cardsJson = json['_linked']['cards'];
    for (var cardJson in cardsJson) {
      var newCard = KeyforgeCard.FromJson(cardJson);
      cards.add(newCard);
    }

    deckTitle = json['data']['name'];
  }

  List<KeyforgeCard> getCardsFromHouse(String houseName) {
    return cards.where((a) => a.house == houseName).toList();
  }
}
