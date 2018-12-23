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

    var cardsDetailed = new List<KeyforgeCard>();
    var cardsDetailedJson = json['_linked']['cards'];
    for (var cardJson in cardsDetailedJson) {
      var newCard = KeyforgeCard.FromJson(cardJson);
      cardsDetailed.add(newCard);
    }

    var cardList = json['data']['_links']['cards'];
    for (String cardId in cardList) {
      cards.add(cardsDetailed.firstWhere((c) => c.id == cardId));
    }

    cards.sort((c1, c2) => c1.card_number.compareTo(c2.card_number));

    deckTitle = json['data']['name'];
  }

  List<KeyforgeCard> getCardsFromHouse(String houseName) {
    return cards.where((a) => a.house == houseName).toList();
  }
}
