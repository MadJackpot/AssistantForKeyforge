class House{
  final String id;
  final String name;
  final String image;

  House.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    name = json['name'],
    image = json['image'];
}
