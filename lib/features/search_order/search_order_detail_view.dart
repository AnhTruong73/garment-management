import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garment_management/common/widgets/text_form_field.dart';
import 'package:garment_management/models/order_model.dart';
import 'package:garment_management/utils/color_utils.dart';

class SearchOrderDetailView extends StatelessWidget {
  final Order order;

  const SearchOrderDetailView({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Chi tiết đơn hàng',
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              TextFormFieldCustomWidget(
                label: "Mã hóa đơn",
                hint: order.orderId,
                inputAction: TextInputAction.next,
                isEnable: false,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormFieldCustomWidget(
                label: "Tên khách hàng",
                hint: order.fullName,
                inputAction: TextInputAction.next,
                isEnable: false,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormFieldCustomWidget(
                label: "Ngày đặt",
                hint: order.creDt.toString(),
                inputAction: TextInputAction.next,
                isEnable: false,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormFieldCustomWidget(
                label: "Số điện thoại",
                hint: order.phoneNumber,
                inputAction: TextInputAction.next,
                isEnable: false,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormFieldCustomWidget(
                label: "Tổng tiền",
                hint: order.totalAmount.toString(),
                inputAction: TextInputAction.next,
                isEnable: false,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormFieldCustomWidget(
                label: "Trạng thái",
                hint: order.status,
                inputAction: TextInputAction.next,
                isEnable: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
