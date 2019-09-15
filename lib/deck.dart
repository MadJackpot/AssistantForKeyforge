import 'package:assistant_for_keyforge/house.dart';
import 'package:assistant_for_keyforge/keyforge_card.dart';

class Deck {
  String deckTitle;
  final houses = new List<House>();
  final cards = new List<KeyforgeCard>();

  Deck.fromJson(Map<String, dynamic> linked, Map<String, dynamic> deck) {
    var houseDetails = linked["houses"];
    var linkedHouses = deck['_links']['houses'];
    for (var house in houseDetails) {
      var houseList = List.from(linkedHouses);
      if (houseList.where((h) => h == house["name"]).isEmpty)
        continue;

      var newHouse = House.fromJson(house);
      houses.add(newHouse);
    }

    var cardsDetailed = new List<KeyforgeCard>();
    var cardsDetailedJson = linked['cards'];
    for (var cardJson in cardsDetailedJson) {
      var newCard = KeyforgeCard.fromJson(cardJson);
      cardsDetailed.add(newCard);
    }

    var cardList = deck['_links']['cards'];
    for (String cardId in cardList) {
      cards.add(cardsDetailed.firstWhere((c) => c.id == cardId));
    }

    cards.sort((c1, c2) => c1.card_number.compareTo(c2.card_number));

    deckTitle = deck['name'];
  }

  List<KeyforgeCard> getCardsFromHouse(String houseName) {
    return cards.where((a) => a.house == houseName).toList();
  }

  List<KeyforgeCard> getAllCards() {
    var allCardsInHouseOrder = new List<KeyforgeCard>();

    allCardsInHouseOrder.addAll(cards.where((c) => c.house == houses[0].name));
    allCardsInHouseOrder.addAll(cards.where((c) => c.house == houses[1].name));
    allCardsInHouseOrder.addAll(cards.where((c) => c.house == houses[2].name));

    return allCardsInHouseOrder;
  }
}
