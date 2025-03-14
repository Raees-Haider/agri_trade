import 'package:agri_trade/controller/Auth_controller.dart';
import 'package:agri_trade/controller/admin_controller.dart';
import 'package:agri_trade/controller/cart_controller.dart';
import 'package:agri_trade/controller/profile_controller.dart';
import 'package:get/get.dart';

import 'controller/product_controller.dart';

Future<void> initApp() async {
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  Get.put(AuthController());
  Get.put(ProfileController());
  Get.put(ProductController());
  Get.put(CartController());
  Get.put(AdminController());
}
