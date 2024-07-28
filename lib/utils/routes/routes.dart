import 'package:flutter/material.dart';
import 'package:garment_management/features/auth/sign_in_view.dart';
import 'package:garment_management/features/bottom_navigator/bottom_navigator_view.dart';
import 'package:garment_management/features/order/order_detail_view.dart';
import 'package:garment_management/features/order/order_info_view.dart';
import 'package:garment_management/features/product/product_view.dart';
import 'package:garment_management/features/search_order/search_order_view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> routeBuilder(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.signIn:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignInView(),
        );
      case RoutesName.bottomNavigator:
        return MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavigationView(),
        );
      case RoutesName.orderDetail:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OrderDetailView(),
        );
      case RoutesName.product:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProductView(),
        );

      case RoutesName.searchOrder:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SearchOrderView(),
        );

      case RoutesName.orderInfo:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OrderInfoView(),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }

  static void goToSignInScreen(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RoutesName.signIn, (Route<dynamic> route) => false);
  }

  static void goToBottomNavigatorScreen(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RoutesName.bottomNavigator, (Route<dynamic> route) => false);
  }

  static void goToProductScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.product);
  }

  static void goToOrderDetailScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.orderDetail);
  }

  static void goToSearchOrderScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.searchOrder);
  }

  static void goToSearchOrderDetailScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.searchOrderDetail);
  }

  static void goToOrderInfoScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.orderInfo);
  }
}
