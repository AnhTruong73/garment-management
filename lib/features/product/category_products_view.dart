import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garment_management/features/product/product_detail_view.dart';
import 'package:garment_management/models/product_model.dart';
import 'package:garment_management/utils/color_utils.dart';

class CategoryProductsView extends StatelessWidget {
  final String categoryTitle;
  final List<Product> products;

  const CategoryProductsView(
      {Key? key, required this.categoryTitle, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          categoryTitle,
          style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            color: ColorUtils.blueLightColor,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailView(product: product)),
              ),
              leading: product.productImg!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Image.network(
                        product.productImg!.first,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image, size: 60);
                        },
                      ),
                    )
                  : Icon(Icons.image, size: 60),
              title: Text(
                product.productName ?? 'No Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${product.price ?? 0} VND'),
            ),
          );
        },
      ),
    );
  }
}
