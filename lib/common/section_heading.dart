import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key, required this.title,  this.viewButtonText = '', this.onPressed, this.showActionButton = true,
  });

  final String title;
  final bool showActionButton;
  final String? viewButtonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title,style: Theme.of(context).textTheme.headlineSmall,)),
          if(showActionButton) TextButton(onPressed: onPressed, child: Text(viewButtonText!))
        ],
      ),
    );
  }
}