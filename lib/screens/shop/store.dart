import 'package:agri_trade/common/cart_button.dart';
import 'package:agri_trade/common/custom_appbar.dart';
import 'package:agri_trade/common/product_card_vertical.dart';
import 'package:agri_trade/common/section_heading.dart';
import 'package:agri_trade/controller/controllers.dart';
import 'package:agri_trade/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
    productController.fetchAcceptedBiddingProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleWidget: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          actionButton: [
            CartButton(
              icon: Iconsax.shopping_bag,
              iconColor: Colors.green,
              onPressed: () => Get.to(() => const Cart()),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                // --- ShowCase
                // const ProductShowcase(),
                // const SizedBox(
                //   height: 10,
                // ),

                // SectionHeading(
                //     title: "You Might Like Products",
                //     // viewButtonText: "View All",
                //     onPressed: () {}),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  itemCount: productController.filteredAcceptedProducts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 288,
                  ),
                  itemBuilder: (_, index) {
                    final product =
                        productController.filteredAcceptedProducts[index];

                    return ZProductCardVertical(
                      title: product.name,
                      description: product.description,
                      price: product.highestBid.toString(),
                      imageUrl: product.image,
                      biddingAccepted: product.accepted,
                      onTap: product.accepted
                          ? () {
                              cartController.addToCart(product);
                            }
                          : () {
                              Get.snackbar("Bidding Not Completed",
                                  "${product.name} is open to bidding");
                            },
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}
