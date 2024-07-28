import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garment_management/features/bottom_navigator/notifier/bottom_navigation_notifier.dart';
import 'package:garment_management/features/home/home_view.dart';
import 'package:garment_management/features/order/order_view.dart';
import 'package:garment_management/features/bill/bill_view.dart';
import 'package:garment_management/utils/color_utils.dart';
import '../../common/base_state_delegate/base_state_delegate.dart';


class BottomNavigationView extends ConsumerStatefulWidget {
  const BottomNavigationView({super.key});

  @override
  BaseStateDelegate<BottomNavigationView, BottomNavigationNotifier>
      createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState
    extends BaseStateDelegate<BottomNavigationView, BottomNavigationNotifier> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initNotifier() {
    notifier = ref.read(bottomNavigationNotifierProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Consumer(
          builder: (context, ref, child) {
            ref.watch(
              bottomNavigationNotifierProvider.select(
                (value) => value.currentIndex,
              ),
            );
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: const [
                HomeView(),
                OrderView(),
                BillView(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: ColorUtils.primaryBackgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Consumer(
            builder: (context, ref, child) {
              final index = ref.watch(
                bottomNavigationNotifierProvider.select(
                  (value) => value.currentIndex,
                ),
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context,
                    index,
                    0,
                    "Home",
                    Icons.home,
                  ),
                  _buildNavItem(
                    context,
                    index,
                    1,
                    "Đặt may",
                    Icons.shopping_cart,
                  ),
                  _buildNavItem(
                    context,
                    index,
                    2,
                    "Hóa đơn",
                    Icons.receipt,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int currentIndex,
    int index,
    String label,
    IconData icon,
  ) {
    final isSelected = currentIndex == index;

    return TextButton(
      onPressed: () {
        _pageController.jumpToPage(index);
        notifier.setCurrentIndex(index);
      },
      style: TextButton.styleFrom(
        foregroundColor:
            isSelected ? ColorUtils.blueColor : ColorUtils.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        textStyle: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: isSelected ? 16 : 14,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color:
                  isSelected ? ColorUtils.blueColor : ColorUtils.primaryColor),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}
