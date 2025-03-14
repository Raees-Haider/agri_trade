
import 'package:agri_trade/screens/agricultural_info.dart';
import 'package:agri_trade/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.green,
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text(
                "Username",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              accountEmail: Text("user@agri_trade.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/brand_artworks/default_prodile_pic.png",
                ),
              ),
            ),
            ListTile(
              title: const Text("Agricultural Info",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              leading: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              onTap: () => Get.to( ChatbotScreen()),
            ),
            ListTile(
              title: const Text("Sign Out",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              leading: const Icon(Icons.logout, color: Colors.white, size: 30),
              onTap: () => Get.offAll(()=> const LoginScreen()),
            ),
          ],
        ),
      ),
    );
  }


}
