import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garment_management/utils/color_utils.dart';
import 'package:garment_management/models/order_model.dart';
import 'package:garment_management/services/order_service.dart';

class BillView extends StatefulWidget {
  const BillView({Key? key}) : super(key: key);

  @override
  _BillViewState createState() => _BillViewState();
}

class _BillViewState extends State<BillView> {
  final OrderService _orderService = OrderService();
  List<Order> _pendingOrders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPendingOrders();
  }

  Future<void> _fetchPendingOrders() async {
    try {
      final orders = await _orderService.fetchOrders();
      setState(() {
        _pendingOrders =
            orders.where((order) => order.status == 'PENDING').toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching orders: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Lập hóa đơn',
          style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.only(bottom: 40),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/images/img_qr.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _pendingOrders.length,
                      itemBuilder: (context, index) {
                        final order = _pendingOrders[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: ColorUtils.blueMiddleColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              'Mã hóa đơn: ${order.orderId}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            subtitle: Text(
                              'Khách hàng: ${order.fullName}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onTap: () => _showConfirmationDialog(order),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(Order order) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có muốn lập hóa đơn cho đơn hàng này không?'),
          actions: <Widget>[
            TextButton(
              child: Text('Không'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Có'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await _updateOrderStatus(order);
    }
  }

  Future<void> _updateOrderStatus(Order order) async {
    try {
      await _orderService.updateOrderStatus(
        orderId: order.orderId,
        status: 'REQUEST',
        userId: '240705',
      );
      await _fetchPendingOrders();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lập hóa đơn thành công')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update order status: $e')),
      );
    }
  }
}
