import 'package:flutter/material.dart';

class KeyforgeCard
{
  final String id;
  final String card_title;
  final String house;
  final String card_type;
  final String front_image;
  final String card_text;
  final String traits;
  final int amber;
  final int power;
  final int armor;
  final String rarity;
  final String flavor_text;
  final int card_number;
  final int expansion;
  final bool is_maverick;

  KeyforgeCard.FromJson(Map<String, dynamic> json)
    : id = json['id'],
      card_title = json['card_title'],
      house = json['house'],
      card_type = json['card_type'],
      front_image = json['front_image'],
      card_text = json['card_text'],
      traits = json['traits'],
      amber = json['amber'],
      power = json['power'],
      armor = json['armor'],
      rarity = json['rarity'],
      flavor_text = json['flavor_text'],
      card_number = json['card_number'],
      expansion = json['expansion'],
      is_maverick = json['is_maverick'];
}