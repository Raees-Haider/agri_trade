import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24 * 2),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              // --- TODO: Image
              const Icon(
                Iconsax.activity,
                size: 200,
              ),

              const SizedBox(
                height: 24,
              ),
              // --- TODO: Title & Subtitle
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 23),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),

              // --- TODO: Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
