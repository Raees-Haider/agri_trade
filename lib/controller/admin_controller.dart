import 'package:agri_trade/model/farmer_model.dart';
import 'package:agri_trade/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminController extends GetxController {
  var farmers = <FarmerModel>[].obs;
  var products = <Product>[].obs;
  Rx userCount = 0.obs;
  static AdminController instance = Get.find<AdminController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchFarmers();
    super.onInit();
  }

  void fetchFarmers() async {
    try {
      final farmerSnapshot = await _firestore.collection('farmers').get();
      final farmerList = farmerSnapshot.docs
          .map((doc) => FarmerModel.fromSnapshot(doc))
          .toList();
      if (kDebugMode) {
        print(farmerList);
      }
      farmers.assignAll(farmerList);
    } catch (e) {
      print('Error fetching farmers: $e');
    }
  }

  Future<void> fetchProductsByFarmer(String farmerId) async {
    try {
      // Fetch products from Firestore and filter by farmerID
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('farmerID', isEqualTo: farmerId) // Filter by farmerID
          .get();

      products.clear(); // Clear existing products list
      for (var doc in snapshot.docs) {
        products.add(Product.fromMap(doc.data() as Map<String, dynamic>));
      }
      update(); // Notify listeners to update UI
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
      print(e);
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      // Step 1: Delete the product from Firestore
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();

      // Step 2: Update the local product list (remove the product)
      products.removeWhere((product) => product.productID == productId);

      // Show a success message
      Get.snackbar('Success', 'Product deleted successfully');

      update(); // Update the UI after deletion
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Failed to delete the product: $e');
      print(e);
    }
  }

  void fetchUserCount() async {
    try {
      final userSnapshot = await _firestore.collection('users').get();
      userCount.value = userSnapshot.size;
      if (kDebugMode) {
        print('Number of users: $userCount');
      }
    } catch (e) {
      print('Error fetching user count: $e');
    }
  }

  Future<void> deleteFarmer(String farmerId) async {
    try {
      // Step 1: Delete the farmer's products from Firestore (if needed)
      // You might want to delete the products related to this farmer first, or handle this differently
      final productsSnapshot = await _firestore
          .collection('products')
          .where('farmerID', isEqualTo: farmerId)
          .get();

      for (var doc in productsSnapshot.docs) {
        await doc.reference
            .delete(); // Delete each product related to the farmer
      }

      // Step 2: Delete the farmer from the 'farmers' collection
      await _firestore.collection('farmers').doc(farmerId).delete();

      // Step 3: Remove the farmer from the local `farmers` list
      farmers.removeWhere((farmer) => farmer.uid == farmerId);

      // Show success message
      Get.snackbar('Success', 'Farmer deleted successfully');

      // Update the UI
      update();
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Failed to delete the farmer: $e');
      print(e);
    }
  }
}
