import 'package:agri_trade/common/custom_appbar.dart';
import 'package:agri_trade/common/product_card_vertical.dart';
import 'package:agri_trade/common/section_heading.dart';
import 'package:agri_trade/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  @override
  void initState() {
    profileController.getFarmerProfile();
    // productController.fetchFarmerProducts();
    productController.fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Header
            const HomeHeader(),

            // --- Popular Products
            SectionHeading(
              title: "All Products",
              viewButtonText: "View All",
              onPressed: () {},
            ),

            // -- Product Grid
            Obx(
              () {
                // Filter products to only include those with the current user's farmerID
                final filteredProducts = productController.products
                    .where((product) =>
                        product.farmerID ==
                        profileController.auth.currentUser?.uid)
                    .toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    // Use the length of filtered products
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      mainAxisExtent: 288,
                    ),
                    itemBuilder: (_, index) {
                      final product = filteredProducts[
                          index]; // Get product from filtered list
                      return Stack(
                        children: [
                          ZProductCardVertical(
                            showVerificationIcon: true,
                            showAddToCartButton: false,
                            title: product.name,
                            productQuantity: product.quantity,
                            description: product.description,
                            biddingAccepted: product.accepted,
                            price: product.highestBid.toString(),
                            imageUrl: product.image,
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: InkWell(
                              onTap: () {
                                adminController
                                    .deleteProduct(product.productID ?? "");
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                );
              },
            ),

            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            // --- Custom AppBar
            CustomAppBar(
              titleWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(profileController.user.value.name ?? "new user",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 20)),
                  )
                ],
              ),
            ),

            // -- Search box
            const SearchWidget(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  const StatusBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Products On Sale",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
                itemCount: 17,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    statusCircularContainer(context, index)),
          )
        ],
      ),
    );
  }

  Widget statusCircularContainer(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Center(
                child: Icon(Iconsax.microphone_slash),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Crops",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            const Icon(
              Iconsax.search_normal,
              color: Colors.green,
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              "Search in Store",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
