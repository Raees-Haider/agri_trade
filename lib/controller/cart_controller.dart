import 'package:agri_trade/model/orderModel.dart';
import 'package:agri_trade/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController instance = Get.find<CartController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<OrderModel> orders = <OrderModel>[].obs;
  RxBool isLoading = false.obs;
  var cartItems = <Product>[].obs;

  void addToCart(Product product) {
    final existingProductIndex =
        cartItems.indexWhere((item) => item.productID == product.productID);

    if (existingProductIndex != -1) {
      Get.snackbar(
          "Already in Cart", "${product.name} is already in your cart");
    } else {
      cartItems.add(product);
    }
  }

  void removeFromCart(Product product) {
    final existingProductIndex =
        cartItems.indexWhere((item) => item.productID == product.productID);

    if (existingProductIndex != -1) {
      // Remove the product from the cart
      cartItems.removeAt(existingProductIndex);
      Get.snackbar("Removed from Cart",
          "${product.name} has been removed from your cart");
    }
  }

  // New method to calculate total price
  double calculateTotal() {
    double total = 0.0;
    for (var product in cartItems) {
      total += product.highestBid; // Assuming product has a price property
    }
    return total;
  }

// Method to save purchased products to Firestore
//   Future<void> savePurchasedProducts(String userId) async {
//     try {
//       // Create a reference to the users collection
//       CollectionReference usersCollection =
//           FirebaseFirestore.instance.collection('users');
//       CollectionReference farmersCollection = FirebaseFirestore.instance
//           .collection('farmers'); // Assuming you have a farmers collection
//
//       // Prepare a list of product maps and a map to track payments
//       List<Map<String, dynamic>> productsMap = cartItems.map((product) {
//         return {
//           'productID': product.productID,
//           'name': product.name,
//           'price': product.highestBid,
//           'farmerId': product.farmerID, // Store farmerId
//         };
//       }).toList();
//
//       // Calculate total price for balance update
//       double totalPrice = cartItems.fold(0, (sum, item) => sum + item.price);
//
//       // Store the purchased products in Firestore for the user
//       await usersCollection.doc(userId).set({
//         'purchasedProducts': FieldValue.arrayUnion(productsMap),
//       }, SetOptions(merge: true));
//
//       // Pay each farmer
//       for (var product in cartItems) {
//         await farmersCollection.doc(product.farmerID).set({
//           'balance':
//               FieldValue.increment(product.price), // Increase farmer's balance
//         }, SetOptions(merge: true));
//       }
//
//       Get.snackbar(
//           "Success", "Purchased products saved and farmers' balances updated.");
//     } catch (e) {
//       Get.snackbar("Error", "Failed to save purchased products: $e");
//     }
//   }

  Future<void> savePurchasedProducts(String userId) async {
    try {
      // Firestore collections
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      CollectionReference farmersCollection =
          FirebaseFirestore.instance.collection('farmers');
      CollectionReference sellPurchasedProductsCollection =
          FirebaseFirestore.instance.collection('sellPurchasedProducts');

      // Get current user details
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      // Prepare a list of product maps
      for (var product in cartItems) {
        // Get farmer details
        DocumentSnapshot farmerSnapshot =
            await farmersCollection.doc(product.farmerID).get();
        Map<String, dynamic> farmerData =
            farmerSnapshot.data() as Map<String, dynamic>;

        // Create a comprehensive transaction record
        await sellPurchasedProductsCollection.add({
          // Buyer Information
          'buyerName': userData['name'] ?? '',
          'buyerEmail': userData['email'] ?? '',
          'buyerPhone': userData['phone'] ?? '',
          'buyerAddress': userData['address'] ?? '',

          // Farmer Information
          'farmerName': farmerData['name'] ?? '',
          'farmerEmail': farmerData['email'] ?? '',
          'farmerPhone': farmerData['phone'] ?? '',
          'farmerAddress': farmerData['address'] ?? '',

          // Product Details
          'productID': product.productID,
          'productName': product.name,
          'productPrice': product.highestBid,

          // Additional Transaction Metadata
          'transactionDate': FieldValue.serverTimestamp(),
          'buyerId': userId,
          'farmerId': product.farmerID,
        });
      }

      // Existing code for updating user purchased products and farmer balances
      List<Map<String, dynamic>> productsMap = cartItems.map((product) {
        return {
          'productID': product.productID,
          'name': product.name,
          'price': product.highestBid,
          'farmerId': product.farmerID,
        };
      }).toList();

      await usersCollection.doc(userId).set({
        'purchasedProducts': FieldValue.arrayUnion(productsMap),
      }, SetOptions(merge: true));

      for (var product in cartItems) {
        await farmersCollection.doc(product.farmerID).set({
          'balance': FieldValue.increment(product.highestBid),
        }, SetOptions(merge: true));
      }

      Get.snackbar("Success", "Transaction details saved successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to save transaction details: $e");
    }
  }

  // Fetch orders for a specific user
  Future<void> fetchUserOrders(String userId) async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await _firestore
          .collection('sellPurchasedProducts')
          .where('buyerId', isEqualTo: userId)
          .get();

      orders.value = querySnapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc))
          .toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to fetch orders: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Fetch orders for a specific farmer
  Future<void> fetchFarmerOrders(String farmerId) async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await _firestore
          .collection('sellPurchasedProducts')
          .where('farmerId', isEqualTo: farmerId)
          .get();

      orders.value = querySnapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc))
          .toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to fetch orders: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
