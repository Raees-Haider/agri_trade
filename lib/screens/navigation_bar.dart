
import 'package:agri_trade/screens/shop/bidding_view.dart';
import 'package:agri_trade/screens/shop/home.dart';
import 'package:agri_trade/screens/shop/profile_screen.dart';
import 'package:agri_trade/screens/shop/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserNavigationMenu extends StatelessWidget {
  const UserNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Obx(
      () => Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          elevation: 0,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: Colors.white.withOpacity(0.1),
          indicatorColor: Colors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.activity), label: 'Bidding'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
        body: controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}
class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final screens = [
    const HomeView(),
    const StoreScreen(),
    const BiddingScreen(),
    const UserProfileScreen()
  ];
}
