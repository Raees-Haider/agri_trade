import 'package:agri_trade/common/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserHistory extends StatelessWidget {
  const UserHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Browsing History",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Iconsax.trash))
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SectionHeading(
              title: "Today",
              showActionButton: false,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    child: const CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Icon(Iconsax.icon),
                    ),
                  ),
                  title: const Text("Crops"),
                  subtitle: const Text("Agri-trade.com"),
                );
              },
            ),
            const SectionHeading(
              title: "Tomorrow",
              showActionButton: false,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    child: const CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Icon(Iconsax.icon),
                    ),
                  ),
                  title: const Text("Crops"),
                  subtitle: const Text("Agri-trade.com"),
                );
              },
            ),
            const SectionHeading(
              title: "1st May",
              showActionButton: false,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    child: const CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Icon(Iconsax.icon),
                    ),
                  ),
                  title: const Text("Crops"),
                  subtitle: const Text("Agri-trade.com"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
