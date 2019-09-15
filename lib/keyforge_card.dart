class KeyforgeCard
{
  final String id;
  // ignore: non_constant_identifier_names
  final String card_title;
  final String house;
  // ignore: non_constant_identifier_names
  final String card_type;
  // ignore: non_constant_identifier_names
  final String front_image;
  // ignore: non_constant_identifier_names
  final String card_text;
  final String traits;
  final int amber;
  final int power;
  final int armor;
  final String rarity;
  // ignore: non_constant_identifier_names
  final String flavor_text;
  // ignore: non_constant_identifier_names
  final int card_number;
  final int expansion;
  // ignore: non_constant_identifier_names
  final bool is_maverick;

  KeyforgeCard.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      card_title = json['card_title'],
      house = json['house'],
      card_type = json['card_type'],
      front_image = json['front_image'],
      card_text = json['card_text'],
      traits = json['traits'],
      amber = json['amber'],
      power = int.parse(json['power']),
      armor = int.parse(json['armor']),
      rarity = json['rarity'],
      flavor_text = json['flavor_text'],
      card_number = int.parse(json['card_number']),
      expansion = json['expansion'],
      is_maverick = json['is_maverick'];
}