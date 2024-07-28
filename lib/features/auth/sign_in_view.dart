import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garment_management/common/widgets/text_button_widget.dart';
import 'package:garment_management/common/widgets/text_form_field.dart';
import 'package:garment_management/services/auth_service.dart';
import 'package:garment_management/utils/color_utils.dart';
import 'package:garment_management/utils/routes/routes.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final AuthService _authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void _login() async {
    final username = nameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bạn cần nhập đủ thông tin')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final loginResponse = await _authService.login(username, password);

    setState(() {
      _isLoading = false;
    });

    if (loginResponse != null && loginResponse.status == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thành công')),
      );
      Routes.goToBottomNavigatorScreen(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                      top: 70, left: 30, right: 30, bottom: 20)
                  .r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/img_logo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: ColorUtils.primaryColor,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(height: 20.h),
                  TextFormFieldCustomWidget(
                    hint: '',
                    label: "Tên đăng nhập",
                    inputAction: TextInputAction.next,
                    controller: nameController,
                  ),
                  SizedBox(height: 20.h),
                  TextFormFieldCustomWidget(
                    hint: '',
                    label: "Mật khẩu",
                    controller: passwordController,
                    inputAction: TextInputAction.done,
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 50.h),
                  TextButtonWidget(
                    label: 'Login',
                    onPressed: _login,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
