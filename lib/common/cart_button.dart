import 'package:agri_trade/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
  });

  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Stack(
        children: [
          IconButton(
            icon: Icon(
              icon,
              size: 28,
              color: iconColor,
            ),
            onPressed: onPressed,
          ),
          Positioned(
            right: 2,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100)),
              child: Obx(
                    ()=> Center(
                  child: Text(
                    cartController.cartItems.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: Colors.white, fontSizeFactor: 0.8),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}