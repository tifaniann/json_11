const keyId = 'id';
const keyName = 'pizzaName';
const keyDescription = 'description';
const keyPrice = 'price';
const keyImage = 'imageUrl';

class Pizza {
  late int id;
  late String pizzaName;
  late String description;
  late double price;
  late String imageUrl;

  Pizza();

  Pizza.fromJson(Map<String, dynamic> json) {
    if ((json[keyId] != null)) {
      id = ((json['id'] != null) ? int.tryParse(json['id'].toString()) : 0)!;
    } else {
      id = 0;
    }
    pizzaName = (json[keyName] != null) ? json[keyName].toString() : '';
    description =
        (json[keyDescription] != null) ? json[keyDescription].toString() : '';
    price = (json[keyPrice] != null &&
            double.tryParse(json[keyPrice].toString()) != null)
        ? json[keyPrice]
        : 0.0;
    imageUrl = (json[keyImage] != null) ? json[keyImage].toString() : '';
  }

  static Pizza? fromJsonOrNull(Map<String, dynamic> json) {
    Pizza pizza = Pizza();
    if ((json[keyId] != null)) {
      pizza.id = ((json['id'] != null) ?
 int.tryParse(json['id'].toString()) : 0)!;
    } else {
      pizza.id = 0;
    }
    pizza.pizzaName = (json[keyName] != null) ? json[keyName].toString() : '';
    pizza.description =
        (json[keyDescription] != null) ? json[keyDescription].toString() : '';
    pizza.price = (json[keyPrice] != null &&
            double.tryParse(json[keyPrice].toString()) != null)
        ? json[keyPrice]
        : 0.0;
    pizza.imageUrl = (json[keyImage] != null) ? json[keyImage].toString() : '';
    if (pizza.id == 0 || pizza.pizzaName.trim() == '') {
      return null;
    }
    return pizza;
  }

  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImage: imageUrl,
    };
  }
}