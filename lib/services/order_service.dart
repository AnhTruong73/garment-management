import 'dart:convert';
import 'package:garment_management/models/order_response.dart';
import 'package:http/http.dart' as http;
import 'package:garment_management/common/config.dart';
import 'package:garment_management/models/order_model.dart' as he;

class OrderService {
  static const String baseUrl = "${Config.baseUrl}/api/v1/order";

  Future<OrderResponse?> createOrder(Map<String, dynamic> orderData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return OrderResponse.fromJson(jsonResponse);
    } else {
      print('HTTP Error: ${response.statusCode}');
      return null;
    }
  }

  Future<List<he.Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((order) => he.Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
    required String userId,
  }) async {
    final response = await http.patch(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'orderId': orderId,
        'status': status,
        'usr_id': userId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update order status');
    }
  }
}
