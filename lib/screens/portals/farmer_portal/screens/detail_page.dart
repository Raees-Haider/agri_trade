import 'package:flutter/material.dart';
class DetailPage extends StatelessWidget {
  const DetailPage({super.key, this.imageUrl, this.title, this.description, this.price, required this.showVerificationIcon, required this.showAddToCartButton, required this.biddingAccepted, required this.productQuantity});

  final String? imageUrl;
  final String? title;
  final String? description;
  final String? price;
  final bool showVerificationIcon;
  final bool showAddToCartButton;

  final bool biddingAccepted;
  final int productQuantity;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(imageUrl!),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title!,style: Theme.of(context).textTheme.headlineSmall,),
                  const SizedBox(
                    height: 12,
                  ),
                  Text('Rs. $price',style: Theme.of(context).textTheme.headlineSmall,),
                  const SizedBox(
                    height: 12,
                  ),
                  Text('Description: $description',),
                  const SizedBox(
                    height: 12,
                  ),
                  Text('Quantity: $productQuantity Ton'.toString(),),
                ],
              ),)
        ],
      ),
    );
  }
}
