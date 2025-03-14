import 'package:agri_trade/controller/Auth_controller.dart';
import 'package:agri_trade/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductController extends GetxController {
  static ProductController instance = Get.find<ProductController>();
  final AuthController authController = Get.find<AuthController>();

  // Controllers for product input
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController bidText = TextEditingController();
  TextEditingController searchController = TextEditingController();

  // Observable variables
  var isLoading = false.obs;
  var pickedImageFile = Rx<File?>(null);
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  final RxList<Product> filteredAcceptedProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Method to pick an image
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImageFile.value = File(image.path);
    }
  }

  Future<void> fetchAcceptedBiddingProducts() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('accepted', isEqualTo: true)
          .get();

      // Create a new list for accepted bidding products
      List<Product> acceptedBiddingProducts = [];

      for (var doc in snapshot.docs) {
        // Convert document data to map
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Check if biddingAccepted exists and is true
        if (data.containsKey('accepted') && data['accepted'] == true) {
          acceptedBiddingProducts.add(Product.fromMap(data));
        }
      }

      // Update the filtered list with accepted bidding products
      filteredAcceptedProducts.value = acceptedBiddingProducts;

      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch accepted bidding products: $e');
      print(e);
    }
  }

  Future<void> uploadProduct() async {
    if (pickedImageFile.value == null) {
      Get.snackbar('Error', 'Please pick an image first.');
      return;
    }

    try {
      isLoading(true);

      final imageRef = FirebaseStorage.instance.ref().child(
          'products/${nameController.text}_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await imageRef.putFile(pickedImageFile.value!);
      final imageUrl = await imageRef.getDownloadURL();

      String? farmerID = authController.auth.currentUser?.uid;
      if (farmerID != null) {
        // Create product object without productID
        Product product = Product(
          name: nameController.text,
          price: double.parse(priceController.text),
          image: imageUrl,
          quantity: int.parse(quantityController.text),
          farmerID: farmerID,
          highestBid: double.parse(priceController.text),
          description: desController.text,
        );

        // Add product to Firestore and get the document reference
        var productDocRef = await FirebaseFirestore.instance
            .collection('farmers')
            .doc(farmerID)
            .collection('products')
            .add(product.toMap());

        // Set productID as the document ID
        product.productID = productDocRef.id;

        // Now save the product again to include the productID
        await productDocRef.set(product.toMap(), SetOptions(merge: true));

        // Also add it to the global products collection
        await FirebaseFirestore.instance
            .collection('products')
            .doc(product.productID)
            .set(product.toMap());

        // Clear controllers after upload
        clearControllers();

        pickedImageFile.value = null;
        Get.snackbar('Success', 'Product uploaded successfully!');
      } else {
        Get.snackbar('Error', 'Failed to get farmer ID.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload product: $e');
    } finally {
      isLoading(false);
    }
  }

  void clearControllers() {
    nameController.clear();
    desController.clear();
    catController.clear();
    quantityController.clear();
    priceController.clear();
    clearImage();
  }

  // Method to fetch all products for a specific farmer
  Future<void> fetchFarmerProducts() async {
    String? farmerID = authController.auth.currentUser?.uid;
    if (farmerID != null) {
      try {
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('farmers')
            .doc(farmerID)
            .collection('products')
            .get();

        products.clear(); // Clear existing products
        for (var doc in snapshot.docs) {
          products.add(Product.fromMap(doc.data() as Map<String, dynamic>));
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch farmer products: $e');
      }
    } else {
      Get.snackbar('Error', 'Failed to get farmer ID.');
    }
  }

  // Method to fetch all global products
  Future<void> fetchAllProducts() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      products.clear(); // Clear existing products
      for (var doc in snapshot.docs) {
        products.add(Product.fromMap(doc.data() as Map<String, dynamic>));
      }

      filteredProducts.value = products; // Show all products if query is empty

      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch all products: $e');
      print(e);
    }
  }

  void clearImage() {
    pickedImageFile.value = null;
  }

  void submit() {
    uploadProduct();
  }

// Method to place a new bid on a product
  Future<void> placeBid({
    required String productID,
    required double bidAmount,
    required String bidderID,
    required String farmerID,
    required String bidderEmail,
    required String bidderName,
  }) async {
    try {
      isLoading(true);

      // Reference to the product document
      DocumentReference productRef =
          FirebaseFirestore.instance.collection('products').doc(productID);

      // Fetch the product to get current highest bid
      DocumentSnapshot productSnapshot = await productRef.get();

      if (!productSnapshot.exists) {
        Get.snackbar('Error', 'Product not found.');
        return;
      }

      // Check if 'highestBid' field exists using containsKey and set default value if not present
      Map<String, dynamic> productData =
          productSnapshot.data() as Map<String, dynamic>;
      double currentHighestBid = productData.containsKey('highestBid')
          ? productData['highestBid']
          : 0.0;

      // Check if the bid amount is higher than the current highest bid
      if (bidAmount > currentHighestBid) {
        // Create a new bid document in the 'bids' sub-collection of the product
        await productRef.collection('bids').add({
          'bidAmount': bidAmount,
          'bidderID': bidderID,
          'accepted': false,
          'bidderEmail': bidderEmail,
          'bidderName': bidderName,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Update the product document with the new highest bid and highest bidder ID
        await productRef.update({
          'highestBid': bidAmount,
          'highestBidderID': bidderID,
          'highestBidderName': bidderName,
          'highestBidderEmail': bidderEmail,
        });
        //update in farmer products
        DocumentReference farmerProductRef = FirebaseFirestore.instance
            .collection('farmers')
            .doc(farmerID)
            .collection('products')
            .doc(productID);
        await farmerProductRef.update({
          'highestBid': bidAmount,
          'highestBidderID': bidderID,
          'highestBidderName': bidderName,
          'highestBidderEmail': bidderEmail,
        });
        update();

        Get.snackbar('Success', 'Your bid has been placed successfully!');
      } else {
        Get.snackbar(
            'Error', 'Bid amount must be higher than the current highest bid.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to place bid: $e');
      print(e);
    } finally {
      isLoading(false);
    }
  }

  // Method to fetch the highest bid for a specific product
  Future<void> fetchHighestBid(String productID, String farmerID) async {
    try {
      isLoading(true);

      // Reference to the product document
      DocumentReference productRef =
          FirebaseFirestore.instance.collection('products').doc(productID);
      DocumentReference farmerProductRef = FirebaseFirestore.instance
          .collection('farmers')
          .doc(farmerID)
          .collection('products')
          .doc(productID);

      // Fetch the highest bid details from the product document
      DocumentSnapshot productSnapshot = await productRef.get();
      if (productSnapshot.exists) {
        //getting details from all products to farmer products
        double highestBid = productSnapshot['highestBid'] ?? 0.0;
        String highestBidderID = productSnapshot['highestBidderID'] ?? '';
        String highestBidderName = productSnapshot['highestBidderName'] ?? '';
        String highestBidderEmail = productSnapshot['highestBidderEmail'] ?? '';
        // updating
        //  await farmerProductRef.update({
        //    'highestBid': highestBid,
        //    'highestBidderID': highestBidderID,
        //    'highestBidderName': highestBidderName,
        //    'highestBidderEmail': highestBidderEmail,
        //  });
        update();
        // int productIndex = products.indexWhere((prod) => prod.productID == productID);
        // if (productIndex != -1) {
        //   products[productIndex].highestBid = highestBid;
        //   products[productIndex].highestBidderID = highestBidderID;
        //   products[productIndex].highestBidderName = highestBidderName;
        //   products[productIndex].highestBidderEmail = highestBidderEmail;
        //   update(); // Notify UI of changes
        // }
        // Get.snackbar('Highest Bid', 'Current Highest Bid: $highestBid by $highestBidderID');
      } else {
        Get.snackbar('Error', 'Product not found.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch highest bid: $e');
    } finally {
      isLoading(false);
    }
  }

// Method to accept a bid and update bid status
  Future<void> acceptBid({
    required String productID,
    required String bidderId,
  }) async {
    try {
      isLoading(true);

      // Reference to the product document
      DocumentReference productRef =
          FirebaseFirestore.instance.collection('products').doc(productID);
      DocumentSnapshot productSnapshot = await productRef.get();

      if (!productSnapshot.exists) {
        Get.snackbar('Error', 'Product not found.');
        return;
      }

      // Retrieve the highest bidder ID from the product document
      String highestBidderId = productSnapshot['highestBidderID'];

      // Reference to the bids collection for this product
      QuerySnapshot bidSnapshot = await productRef.collection('bids').get();
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Iterate through all bids and update their 'accepted' status
      for (var bidDoc in bidSnapshot.docs) {
        // Get the bidderID from the bid document
        String currentBidderId = bidDoc['bidderID'];

        // Set 'accepted' to true if the current bidderID matches the highest bidderID
        batch.update(
            bidDoc.reference, {'accepted': currentBidderId == highestBidderId});
      }
      batch.update(productRef, {'accepted': true});

      // Commit the batch update
      await batch.commit();
      update();
      Get.snackbar('Success', 'Bid has been accepted successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to accept bid: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.value = products; // Show all products if query is empty
    } else {
      filteredProducts.value = products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}
