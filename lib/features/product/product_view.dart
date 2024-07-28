import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garment_management/features/product/category_products_view.dart';
import 'package:garment_management/features/product/product_detail_view.dart';
import 'package:garment_management/models/product_model.dart';
import 'package:garment_management/services/product_service.dart';
import 'package:garment_management/utils/color_utils.dart';
import 'package:garment_management/common/widgets/search_form_field.dart'; // Import your SearchFormField widget

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ProductService _productService = ProductService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Tra cứu sản phẩm',
          style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchFormField(
              hint: 'Tìm kiếm sản phẩm...',
              controller: _searchController,
              prefixIcon: Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.only(bottom: 40),
        child: FutureBuilder<ProductResponse?>(
          future: _productService.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No products available'));
            }

            final products = snapshot.data!.data!.rows!
                .where((p) => p.productName!
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()))
                .toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategorySection('Áo vest',
                      products.where((p) => p.category == 'VEST').toList()),
                  SizedBox(height: 10),
                  _buildCategorySection('Áo sơ mi',
                      products.where((p) => p.category == 'SHIRT').toList()),
                  SizedBox(height: 10),
                  _buildCategorySection('Quần dài',
                      products.where((p) => p.category == 'TROUSERS').toList()),
                  SizedBox(height: 10),
                  _buildCategorySection('Áo blazer',
                      products.where((p) => p.category == 'BLAZER').toList()),
                  SizedBox(height: 10),
                  _buildCategorySection('Áo gile',
                      products.where((p) => p.category == 'GILE').toList()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryTitle, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(categoryTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductsView(
                        categoryTitle: categoryTitle, products: products),
                  ),
                );
              },
              child: Text('Xem tất cả',
                  style: TextStyle(color: ColorUtils.primaryColor)),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 150.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailView(product: product)),
                ),
                child: Card(
                  color: ColorUtils.blueLightColor,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        product.productImg!.isNotEmpty
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                child: Image.network(
                                  product.productImg!.first,
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 120,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.image, size: 100);
                                  },
                                ),
                              )
                            : Icon(Icons.image, size: 100),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.productName ?? 'No Name',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('${product.price ?? 0} VND',
                              style: TextStyle(
                                  fontSize: 12, color: ColorUtils.greenColor)),
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
    );
  }
}
