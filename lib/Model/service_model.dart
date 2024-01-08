class ServiceProduct {
  final int id;
  final String mainImage;
  final double price;
  final double? discount;
  final double priceAfterDiscount;
  final String title;
  final double averageRating;
  final int completedSalesCount;
  final bool recommended;

  ServiceProduct({
    required this.id,
    required this.mainImage,
    required this.price,
    required this.discount,
    required this.priceAfterDiscount,
    required this.title,
    required this.averageRating,
    required this.completedSalesCount,
    required this.recommended,
  });

  factory ServiceProduct.fromJson(Map<String, dynamic> json) {
    return ServiceProduct(
      id: json['id'],
      mainImage: json['main_image'],
      price: (json['price'] ?? 0.0).toDouble(),
      discount: json['discount']?.toDouble(),
      priceAfterDiscount: (json['price_after_discount'] ?? 0.0).toDouble(),
      title: json['title'],
      averageRating: (json['average_rating'] ?? 0.0).toDouble(),
      completedSalesCount: json['completed_sales_count'],
      recommended: json['recommended'],
    );
  }

  static List<ServiceProduct> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ServiceProduct.fromJson(json)).toList();
  }
}
