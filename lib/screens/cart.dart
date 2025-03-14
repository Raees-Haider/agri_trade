import 'package:agri_trade/controller/controllers.dart';
import 'package:agri_trade/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/custom_appbar.dart';
import '../common/product_card_vertical.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              titleWidget: Text(
                "Cart",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              actionButton: [
                IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.add_shopping_cart_rounded,
                      size: 26,
                      color: Colors.green,
                    ))
              ],
            ),
            Obx(() {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                child: GridView.builder(
                    itemCount: cartController.cartItems.length,
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
                      final cartProducts = cartController.cartItems[index];

                      return ZProductCardVertical(
                        title: cartProducts.name,
                        description: cartProducts.description,
                        price: cartProducts.highestBid.toString(),
                        imageUrl: cartProducts.image,
                        showAddToCartButton: false,
                        biddingAccepted: cartProducts.accepted,
                        removeToCart: true,
                        onTap: () {
                          cartController.removeFromCart(cartProducts);
                        },
                      );
                    }),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              double totalPrice = cartController.calculateTotal();
              return Text(
                'Total Price: Rs ${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
            ElevatedButton(
              style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 10))),
              onPressed: () async {
                double totalPrice = cartController.calculateTotal();
                StripeService.instance.makePayment(
                  amount: totalPrice,
                  customerEmail: "pay@gmail.com",
                  customerName: "user512",
                );
              },
              child: Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
