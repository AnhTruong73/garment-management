class ProductResponse {
  final int? status;
  final String? message;
  final ProductData? data;

  ProductResponse({this.status, this.message, this.data});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
    );
  }
}

class ProductData {
  final List<Product>? rows;

  ProductData({this.rows});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      rows: (json['rows'] as List<dynamic>?)
          ?.map((item) => Product.fromJson(item))
          .toList(),
    );
  }
}

class Product {
  final String? productId;
  final String? productName;
  final int? price;
  final String? category;
  final String? description;
  final List<String>? productImg;
  Product({
    this.productId,
    this.productName,
    this.price,
    this.category,
    this.description,
    this.productImg,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      productImg: json['product_img'] != null
          ? (json['product_img'] as String)
              .split(';')
              .where((img) => img.isNotEmpty)
              .map((img) => '$img')
              .toList()
          : [],
    );
  }
}
