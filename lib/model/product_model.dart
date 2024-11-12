class Product {
  final Map<String, dynamic> json;

  Product(this.json);

  int get id => json['id'];

  String get title => json['title'];

  dynamic get price => json['price'];

  String get description => json['description'];

  String get category => json['category'];

  String get image => json['image'];

  Rating get rating => Rating(json['rating']);
}

class Rating {
  final Map<String, dynamic> json;

  Rating(this.json);

  dynamic get rate => json['rate'];

  int get count => json['count'];
}
