import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final IconData icon;
  final String title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(
        icon,
        size: 35,
        color: Colors.green,
      ),
      title: Text(
        title,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      onTap: onPressed,
    );
  }
}
