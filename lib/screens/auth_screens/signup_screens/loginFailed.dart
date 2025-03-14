import 'package:agri_trade/screens/auth_screens/signup_screens/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../login_screen.dart';

// ignore: camel_case_types
class loginFailed extends StatelessWidget {
  const loginFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: ()=> Get.back() , icon: const Icon(CupertinoIcons.clear))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
const Icon(Iconsax.eye,size: 200,color: Colors.red,),

            const SizedBox(
              height: 24,
            ),
            // --- TODO: Title & Subtitle
            Text(
              "support@agri-trade.com",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "support@codingwitht.com",
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "INVALID CREDENTIALS.\nTRY AGAIN",
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
                onPressed: () => Get.off(SuccessScreen(
                  image: "",
                  title: "INVALID LOGIN",
                  subTitle: "TRY AGAIN",
                  onPressed: () => Get.off(const LoginScreen()),
                )),
                child: const Text("Continue"),
              ),
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
