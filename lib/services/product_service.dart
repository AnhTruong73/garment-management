
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:garment_management/models/product_model.dart';
import 'package:garment_management/common/config.dart';

class ProductService {
  static const String baseUrl = "${Config.baseUrl}/api/v1/product";

  Future<ProductResponse?> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return ProductResponse.fromJson(jsonResponse);
    } else {
      print('HTTP Error: ${response.statusCode}');
      return null;
    }
  }
}
