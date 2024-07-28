import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garment_management/common/widgets/search_form_field.dart';
import 'package:garment_management/features/search_order/search_order_detail_view.dart';
import 'package:garment_management/models/order_model.dart';
import 'package:garment_management/services/order_service.dart';
import 'package:garment_management/utils/color_utils.dart';

class SearchOrderView extends StatefulWidget {
  const SearchOrderView({Key? key}) : super(key: key);

  @override
  _SearchOrderViewState createState() => _SearchOrderViewState();
}

class _SearchOrderViewState extends State<SearchOrderView> {
  List<Order> _orders = [];
  bool _loading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      OrderService apiService = OrderService();
      List<Order> orders = await apiService.fetchOrders();
      setState(() {
        _orders = orders;
        _loading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Order> filteredOrders = _orders
        .where((order) => order.fullName.contains(_searchQuery))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Tra cứu thông tin đơn hàng',
          style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchFormField(
              hint: 'Tìm kiếm ...',
              prefixIcon: Icon(Icons.search),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            SizedBox(height: 10.h),
            Text(
              'Kết quả',
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(height: 10.h),
            _loading
                ? Center(child: CircularProgressIndicator())
                : filteredOrders.isEmpty
                    ? Center(child: Text('Không tìm thấy đơn hàng'))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: filteredOrders.length,
                          itemBuilder: (context, index) {
                            final order = filteredOrders[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchOrderDetailView(
                                            order: order,
                                          )),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: ColorUtils.blueMiddleColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                height: 100.h,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 300.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Mã đơn hàng: ${order.orderId}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Mã khách hàng: ${order.customer.customerId}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp),
                                            ),
                                            Text(
                                              'Tên khách hàng: ${order.fullName}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
}
