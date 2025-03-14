import 'package:agri_trade/common/product_card_vertical.dart';
import 'package:agri_trade/common/section_heading.dart';
import 'package:agri_trade/controller/controllers.dart';
import 'package:agri_trade/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../common/cart_button.dart';
import '../../common/custom_appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    profileController.getUserDetails();
    productController.fetchAllProducts();
    productController.fetchAcceptedBiddingProducts();
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
              title: "Crop Products",
              viewButtonText: "View All",
              onPressed: () {},
            ),
            // -- Product Grid
            Obx(
              () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: GridView.builder(
                      itemCount: productController.filteredProducts.length,
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
                        final product =
                            productController.filteredProducts[index];
                        return ZProductCardVertical(
                          title: product.name,
                          productQuantity: product.quantity,
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
                      }),),
            )
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
                  ),
                  // Text("Mr. Aneeq",
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .headlineMedium!
                  //         .copyWith(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w800,
                  //             fontSize: 20))
                ],
              ),
              actionButton: [
                CartButton(
                  icon: Iconsax.shopping_bag,
                  iconColor: Colors.white,
                  onPressed: () => Get.to(() => const Cart()),
                )
              ],
            ),

            // -- Search box
            const SearchWidget(),
            const SizedBox(
              height: 20,
            ),

            // --- Product On Sale
            // const StatusBar(),
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
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: productController.searchController,
                onChanged: (value) {
                  productController.searchProducts(value);
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Iconsax.search_normal,
                    color: Colors.green,
                  ),
                  hintText: "Search in Store",
                  border: InputBorder.none,
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
