import 'package:agri_trade/screens/auth_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Headings
              Text(
                "Forget Password",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                  "Don't worry sometimes people can forget too, enter your email and we will send you a password reset link."),
              const SizedBox(
                height: 24 * 2,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: "E-mail", prefixIcon: Icon(Iconsax.direct_right)),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
        
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: emailController.text.trim());
                      Get.snackbar(
                          "Password Reset", "Secure Link Send to your email");
                    } catch (e) {
                      Get.snackbar("Error:", e.toString());
                    }
                    Get.to(const LoginScreen());
                  },
                  child: const Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
