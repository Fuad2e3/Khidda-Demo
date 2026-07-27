class Dish {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final bool isAvailable;
  final List<String>? customizations;

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating = 0.0,
    this.isAvailable = true,
    this.customizations,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      rating: json['rating']?.toDouble() ?? 0.0,
      isAvailable: json['isAvailable'] ?? true,
      customizations: json['customizations'] != null ? List<String>.from(json['customizations']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'isAvailable': isAvailable,
      'customizations': customizations,
    };
  }
}
