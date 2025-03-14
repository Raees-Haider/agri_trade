import 'package:agri_trade/constraints/consts.dart';
import 'package:agri_trade/controller/controllers.dart';
import 'package:agri_trade/screens/auth_screens/login_screen.dart';
import 'package:agri_trade/services/send_notification_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment({
    required double amount,
    required String customerName,
    required String customerEmail,
  }) async {
    // Check if the amount is valid
    if (amount <= 0) {
      print("Error: Invalid amount provided. Cannot proceed with payment.");
      return;
    }

    try {
      // Create the payment intent with the provided amount
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount,
        "pkr",
      );

      if (paymentIntentClientSecret == null) {
        print("Error: Failed to create payment intent.");
        return;
      }

      print(
          "Payment Intent created successfully. Client Secret: $paymentIntentClientSecret");

      // Initialize payment sheet and include customer information
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "MyAppName",
          customerId: customerEmail, // Pass the customer's email
        ),
      );

      print("Payment Sheet initialized successfully.");

      // Process the payment
      await _processPayment(customerName);
    } catch (e) {
      print("Error during payment: $e");
    }
  }

  Future<String?> _createPaymentIntent(double amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.data != null) {
        print("Payment Intent response received.");
        return response.data["client_secret"];
      }
      print("Error: No response data found.");
      return null;
    } catch (e) {
      print("Error creating payment intent: $e");
    }
    return null;
  }

  Future<void> _processPayment(String customerName) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        debugPrint("paid succssfully");
        cartController.savePurchasedProducts(profileController.user.value.uid!);
        SendNotificationService.sendNotificationUsingApi(
            body: profileController.user.value.email,
            token: fcmToken,
            title: 'Payment successful',
            data: {});
        Stripe.instance.confirmPaymentSheetPayment();
      }).onError((error, stackTrace) {
        debugPrint("Error makePayment: $error");
      });
    } on StripeException catch (error) {
      debugPrint("strike exception $error");
    }
  }

  // Convert the amount from double to the smallest currency unit (e.g., cents)
  String _calculateAmount(double amount) {
    final calculatedAmount =
        (amount * 100).toInt(); // For USD, convert dollars to cents
    return calculatedAmount.toString();
  }
}
