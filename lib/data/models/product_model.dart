class ProductModel {
  String category;
  String description;
  String id;
  List<dynamic> images;
  String name;
  num price;
  List<dynamic> sizes;

  ProductModel(
      {required this.category,
      required this.description,
      required this.id,
      required this.images,
      required this.name,
      required this.price,
      required this.sizes});

  ProductModel.fromJson(Map<String, dynamic> json)
      : category = json["category"],
        description = json["desc"],
        id = json["id"],
        images = json['images'],
        name = json['name'],
        price = json['price'],
        sizes = json['sizes'];

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'id': id,
      'images': images,
      'name': name,
      'price': price,
      'sizes': sizes
    };
  }
}
