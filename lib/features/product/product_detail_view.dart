import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garment_management/common/widgets/text_form_field.dart';
import 'package:garment_management/models/product_model.dart';
import 'package:garment_management/utils/color_utils.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;

  const ProductDetailView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Chi tiết sản phẩm',
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
              SizedBox(height: 20),
              Center(
                child: product.productImg!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Image.network(
                          product.productImg!.first,
                          fit: BoxFit.cover,
                          height: 200,
                          width: 200,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image, size: 200);
                          },
                        ),
                      )
                    : Icon(Icons.image, size: 200),
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                label: "Mã sản phẩm",
                inputAction: TextInputAction.next,
                hint: product.productId ?? '',
                isEnable: false,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                label: "Tên sản phẩm",
                inputAction: TextInputAction.next,
                hint: product.productName ?? '',
                isEnable: false,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                label: "Đơn giá",
                inputAction: TextInputAction.next,
                hint: product.price?.toString() ?? '',
                isEnable: false,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                label: "Size",
                inputAction: TextInputAction.next,
                isEnable: false,
                // hint: product.category ?? '',
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                label: "Kiểu sản phẩm",
                inputAction: TextInputAction.next,
                hint: product.category ?? '',
                isEnable: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
