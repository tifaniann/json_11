
class Pizza {
  late int id;
  late String pizzaName;
  late String description;
  late double price;
  late String imageUrl;

  Pizza.fromJson(Map<String, dynamic> json){
    id = json['id'];
    pizzaName = json['pizzaName'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['imageUrl'];
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': pizzaName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}