import 'dart:async';

import 'package:agri_trade/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptBiddingScreen extends StatefulWidget {
  const AcceptBiddingScreen({super.key});

  @override
  State<AcceptBiddingScreen> createState() => _AcceptBiddingScreenState();
}

class _AcceptBiddingScreenState extends State<AcceptBiddingScreen> {
  @override
  void initState() {
    productController.fetchAllProducts();
    super.initState();
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
              () {
                final filteredProducts = productController.products.where((product) => product.farmerID == profileController.auth.currentUser?.uid).toList();

                return ListView.builder(
                      itemCount: filteredProducts.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return  _AcceptBiddingCard(
                          imageUrl: product.image,
                          title: product.name,
                          currentBid: product.highestBid.toString(),
                          highestBidderName: product.highestBidderName??"",
                          highestBidderEmail: product.highestBidderEmail??"",
                          productId: product.productID??"",
                          bidderId: product.highestBidderID??"",
                        //  numberOfBids: '0',
                        );
                      },
                    );
                }
              ),


              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    productController.fetchAllProducts();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Refresh"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AcceptBiddingCard extends StatelessWidget {
  const _AcceptBiddingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.currentBid = "",
    this.numberOfBids = "Number of Bid",
    this.buttonLabel = "Accept",
    required this.highestBidderName,
    required this.highestBidderEmail,
    required this.productId,
    required this.bidderId,
  });
final  String productId,bidderId;

  final String imageUrl, title, numberOfBids, currentBid, buttonLabel,highestBidderName,highestBidderEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Row(
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
                    Text(
                      numberOfBids,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 2),
                    Text(
                     "current Bid $currentBid",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                         productController.acceptBid(productID:productId , bidderId: bidderId);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Accept"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "Highest Bidder Name: $highestBidderName",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Email: $highestBidderEmail",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}