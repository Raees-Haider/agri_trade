import 'dart:async';

import 'package:agri_trade/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class BiddingScreen extends StatefulWidget {
//   const BiddingScreen({super.key});
//
//   @override
//   State<BiddingScreen> createState() => _BiddingScreenState();
// }
//
// class _BiddingScreenState extends State<BiddingScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     profileController.getUserDetails();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 70,
//               ),
//               Text(
//                 "Bidding On Your Products",
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               ListView.builder(
//                 itemCount: productController.products.length,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final product = productController.products[index];
//
//                   return  _acceptBiddingCard(
//                     imageUrl: product.image,
//                     title: product.name,
//                     numberOfBids: '0',
//                    productId: product.farmerID,
//                    // controller: productController.bidText,
//
//                   );
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _acceptBiddingCard extends StatelessWidget {
//    _acceptBiddingCard({
//     super.key,
//     required this.imageUrl,
//     required this.title ,
//      this.numberOfBids = "Number of Bid",
//     this.currentBid = "Current Bid",
//     this.buttonLabel = "Place on Bid",
//      required this.productId,
//
//   //  required this.controller,
//
//   });
//  // TextEditingController controller =TextEditingController();
//
//   final String imageUrl, title, numberOfBids, currentBid, buttonLabel,productId;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(12)),
//         color: Colors.grey.withOpacity(0.2),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Product Image
//           SizedBox(
//             width: MediaQuery.of(context).size.width / 3,
//             child: AspectRatio(
//               aspectRatio: 1.0, // Maintain aspect ratio
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   image: DecorationImage(
//                     image: NetworkImage(imageUrl),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//
//           // Product Detail
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(height: 4),
//                  TextField(
//                   controller: productController.bidText,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                   enabledBorder:OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.black)),
//                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.green)),
//                   ),
//                 ),
//                 // Text(
//                 //   numberOfBids,
//                 //   style: const TextStyle(color: Colors.grey),
//                 // ),
//                 // const SizedBox(height: 2),
//                 // const Divider(color: Colors.grey),
//                 const SizedBox(height: 2),
//                 Text(
//                   currentBid,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       productController.placeBid(productID:'6eW6eugzJlpvxHVdK5a5',
//                         bidAmount: double.parse(productController.bidText.text),
//                         bidderID: profileController.user.value.uid??"null",
//                         bidderName: profileController.user.value.name??"null",
//                         bidderEmail: profileController.user.value.email??"null",
//                       );
//                      // Get.snackbar("Product", "Bid Confirmed");
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text("Place on Bid"),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class BiddingScreen extends StatefulWidget {
  const BiddingScreen({super.key});

  @override
  State<BiddingScreen> createState() => _BiddingScreenState();
}

class _BiddingScreenState extends State<BiddingScreen> {
  // List to hold TextEditingControllers for each product
  final List<TextEditingController> _bidControllers = [];

  @override
  void initState() {
    profileController.getUserDetails();
    productController.fetchAllProducts();
    // Initialize controllers for each product based on the number of products
    _bidControllers.addAll(List.generate(
        productController.products.length, (index) => TextEditingController()));

    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _bidControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Text(
                "Bidding On Your Products",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Obx(
                    ()=> ListView.builder(
                  itemCount: productController.products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return  _BiddingCard(
                        imageUrl: product.image,
                        title: product.name,
                        numberOfBids: '0',
                        productId: product.productID??'',
                        controller: _bidControllers[index],
                        currentBid: product.highestBid.toString(),
                      farmerId: product.farmerID,
                      bidStatus: product.accepted,

                        // Use individual controller for each product

                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BiddingCard extends StatelessWidget {
  const _BiddingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.numberOfBids = "Number of Bid",
    this.currentBid = "0.0",
    this.buttonLabel = "Place on Bid",
    required this.productId,
    required this.controller,
    required this.farmerId,
    required this.bidStatus,
  });

  final String imageUrl, title, numberOfBids, currentBid, buttonLabel, productId,farmerId;
  final TextEditingController controller;
  final bool bidStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: AspectRatio(
              aspectRatio: 1.0, // Maintain aspect ratio
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product Detail
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                !bidStatus?
                TextField(
                  controller: controller, // Use unique controller
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.green)),
                  ),
                ):SizedBox.shrink(),
                const SizedBox(height: 2),
                Text(
                  "Current highest Bid $currentBid",
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:bidStatus? (){
                      Get.snackbar('Success', 'Bidding has been close for this product');
                    }:() {
                      productController.placeBid(
                        productID: productId,
                        bidAmount: double.parse(controller.text),
                        bidderID: profileController.user.value.uid ?? "null",
                        bidderName: profileController.user.value.name ?? "null",
                        bidderEmail:
                        profileController.user.value.email ?? "null", farmerID: farmerId,
                      );
                      controller.clear();
                      Timer(Duration(milliseconds: 1500), () {
                        productController.fetchAllProducts();

                      },);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:  Text(!bidStatus? "Place on Bid":"Bidding close"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
