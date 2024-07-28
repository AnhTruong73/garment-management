import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garment_management/common/widgets/text_form_field.dart';
import 'package:garment_management/utils/color_utils.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({Key? key}) : super(key: key);

  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Chi tiết đặt may',
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
                height: 20,
              ),
              Row(
                children: [
                  FlutterLogo(
                    size: 50,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  
                    children: [
                      Text(
                        'Tên sản phẩm',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Size',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldCustomWidget(
                hint: '',
                label: "Mã sản phẩm",
                inputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldCustomWidget(
                hint: '',
                label: "Tên khách hàng",
                inputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldCustomWidget(
                hint: '',
                label: "Số điện thoại",
                inputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldCustomWidget(
                hint: '',
                label: "Địa chỉ",
                inputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
