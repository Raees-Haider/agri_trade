import 'package:agri_trade/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgriTrade extends StatefulWidget {
  const AgriTrade({super.key});

  @override
  State<AgriTrade> createState() => _AgriTradeState();
}

class _AgriTradeState extends State<AgriTrade> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
