
import 'package:agri_trade/screens/portals/farmer_portal/screens/add_products.dart';
import 'package:agri_trade/screens/portals/farmer_portal/screens/bidding_screen.dart';
import 'package:agri_trade/screens/portals/farmer_portal/screens/farmer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'screens/farmer_profile.dart';

class FarmerNavigationMenue extends StatelessWidget {
  const FarmerNavigationMenue({super.key});

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
            NavigationDestination(icon: Icon(Iconsax.home), label: 'All Products'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Add Products'),
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
    const FarmerHomeScreen(),
    const AddProductsScreen(),
    const AcceptBiddingScreen(),
    const FarmerProfile()
  ];
}
