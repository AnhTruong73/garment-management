import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garment_management/common/widgets/text_button_widget.dart';
import 'package:garment_management/common/widgets/text_form_field.dart';
import 'package:garment_management/utils/color_utils.dart';
import 'package:garment_management/models/product_model.dart';
import 'package:garment_management/services/product_service.dart';
import 'package:garment_management/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderInfoView extends StatefulWidget {
  const OrderInfoView({Key? key}) : super(key: key);

  @override
  _OrderInfoViewState createState() => _OrderInfoViewState();
}

class _OrderInfoViewState extends State<OrderInfoView> {
  final ProductService _productService = ProductService();
  final OrderService _orderService = OrderService();

  List<Product>? _products;
  Product? _selectedProduct;
  String usrid = '';

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bustController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipsController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _shippingAddressController =
      TextEditingController();
  final TextEditingController _shippingMethodController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _loadUserDetails();
  }

  void _fetchProducts() async {
    final response = await _productService.fetchProducts();
    setState(() {
      _products = response?.data?.rows ?? [];
    });
  }

  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      usrid = prefs.getString('usrid') ?? 'Guest';
    });
  }

  void _submitOrder() async {
    if (_selectedProduct == null ||
        _heightController.text.isEmpty ||
        _weightController.text.isEmpty ||
        _bustController.text.isEmpty ||
        _waistController.text.isEmpty ||
        _hipsController.text.isEmpty ||
        _fullNameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _customerIdController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _shippingAddressController.text.isEmpty ||
        _shippingMethodController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final orderData = {
      "height": int.parse(_heightController.text),
      "weight": int.parse(_weightController.text),
      "bust": int.parse(_bustController.text),
      "waist": int.parse(_waistController.text),
      "hips": int.parse(_hipsController.text),
      "price": _selectedProduct?.price,
      "productId": _selectedProduct!.productId,
      "branchId": "HCM01",
      "usr_id": usrid,
      "fullName": _fullNameController.text,
      "phoneNumber": _phoneNumberController.text,
      "totalAmount": _selectedProduct?.price,
      "customerId": _customerIdController.text,
      "email": _emailController.text,
      "shippingAddress": _shippingAddressController.text,
      "shippingMethod": _shippingMethodController.text,
      "est_delivery": DateTime.now().toString(),
      "actual_delivery": DateTime.now().toString()
    };

    final response = await _orderService.createOrder(orderData);

    if (response != null && response.status == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lập phiếu may thành công'),
          backgroundColor: Colors.blue,
        ),
      );
      print('Order created successfully!');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi lập phiếu may'),
          backgroundColor: Colors.red,
        ),
      );
      print('Failed to create order.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryBackgroundColor,
        title: Text(
          'Lập phiếu may',
          style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          SizedBox(width: 20),
        ],
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
              Row(
                children: [
                  _selectedProduct != null &&
                          _selectedProduct!.productImg!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            _selectedProduct!.productImg!.first,
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.image, size: 50);
                            },
                          ),
                        )
                      : Icon(Icons.image, size: 50),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedProduct?.productName ?? 'Tên sản phẩm',
                        style: TextStyle(fontSize: 18),
                      ),
                      // Text(
                      //   'Size',
                      //   style: TextStyle(fontSize: 18),
                      // ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              DropdownButton<Product>(
                hint: Text('Chọn sản phẩm'),
                value: _selectedProduct,
                onChanged: (Product? newValue) {
                  setState(() {
                    _selectedProduct = newValue;
                  });
                },
                items: _products
                    ?.map<DropdownMenuItem<Product>>((Product product) {
                  return DropdownMenuItem<Product>(
                    value: product,
                    child: Text(product.productName ?? 'No Name'),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                label: "Mã sản phẩm",
                hint: _selectedProduct?.productId ?? '',
                inputAction: TextInputAction.next,
                isEnable: false,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _heightController,
                label: "Chiều cao",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _weightController,
                label: "Cân nặng",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _bustController,
                label: "Vòng ngực",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _waistController,
                label: "Vòng eo",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _hipsController,
                label: "Vòng mông",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                hint: _selectedProduct?.price.toString() ?? '',
                label: "Giá",
                inputAction: TextInputAction.next,
                isEnable: false,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _fullNameController,
                label: "Tên khách hàng",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _phoneNumberController,
                label: "Số điện thoại",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                hint: _selectedProduct?.price.toString() ?? '',
                label: "Tổng số tiền",
                inputAction: TextInputAction.next,
                isEnable: false,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _customerIdController,
                label: "Mã khách hàng",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _emailController,
                label: "Email",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _shippingAddressController,
                label: "Địa chỉ giao hàng",
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormFieldCustomWidget(
                controller: _shippingMethodController,
                label: "Phương thức giao hàng",
                inputAction: TextInputAction.next,
              ),
              // SizedBox(height: 20),
              // TextFormFieldCustomWidget(
              //   controller: _estDeliveryController,
              //   label: "Ngày giao dự kiến",
              //   inputAction: TextInputAction.next,
              // ),
              // SizedBox(height: 20),
              // TextFormFieldCustomWidget(
              //   controller: _actualDeliveryController,
              //   label: "Ngày giao thực tế",
              //   inputAction: TextInputAction.done,
              // ),
              SizedBox(height: 20),
              TextButtonWidget(
                label: "Lập phiếu may",
                onPressed: _submitOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
