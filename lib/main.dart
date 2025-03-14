import 'package:agri_trade/constraints/consts.dart';
import 'package:agri_trade/init_app.dart';
import 'package:agri_trade/myapp.dart';
import 'package:agri_trade/services/notification_service.dart';
import 'package:agri_trade/theme/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  await _setup();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.requestPermission();
  await initApp();
  runApp(MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    //  notificationService.initNotifications(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NotificationService().firebaseInit(context);

    return GetMaterialApp(
      title: 'Agri Trade',
      theme: AppTheme.lightTheme,
      home: AgriTrade(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void subscribe() {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.subscribeToTopic('all');
  print("Subscribe to all topic");
}
