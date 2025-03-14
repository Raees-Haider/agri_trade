import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductShowcase extends StatelessWidget {
  const ProductShowcase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- ShowCase Header
          Row(
            children: [
              const SizedBox(width: 10,),
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(100)),
                    border: Border.all(color: Colors.grey)),
                child: const Image(
                  image: AssetImage("assets/products/product_1.jpeg"),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Khad",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Icon(
                        Iconsax.verify5,
                        color: Colors.green,
                        size: 18,
                      )
                    ],
                  ),
                  Text(
                    "256 Products",
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              RoundedBrandContainer(),
              RoundedBrandContainer(),
              RoundedBrandContainer(),
            ],
          ),
        ],
      ),
    );
  }
}

class RoundedBrandContainer extends StatelessWidget {
  const RoundedBrandContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16)),
        child: const Center(
          child: Image(
            fit: BoxFit.contain,
            image: AssetImage("assets/products/product_3.png"),
          ),
        ),
      ),
    );
  }
}