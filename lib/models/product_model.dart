class ProductModel {
  final String id;
  final String name;
  final String category;
  final String price;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromMap(String id, Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      name: data['name'] ?? "",
      category: data['category'] ?? "",
      price: data['price'] ?? "",
      description: data['description'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'description': description,
    };
  }
}
