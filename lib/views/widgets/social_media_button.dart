import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String iconName;
  final void Function()? onTap;

  const SocialMediaButton({
    super.key,
    required this.iconName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Image.asset(
            iconName,
            fit: BoxFit.cover,
            height: 40,
            width: 40,
          ),
        ),
      ),
    );
  }
}
