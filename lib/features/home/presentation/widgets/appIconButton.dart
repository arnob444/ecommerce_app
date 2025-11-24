import 'package:flutter/material.dart';

class appBarIconButton extends StatelessWidget {
  const appBarIconButton({
    super.key,
    required this.onTap,
    required this.iconData,
  });

  final VoidCallback onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey.shade300,
          child: Icon(iconData, color: Colors.grey, size: 17),
        ),
      ),
    );
  }
}