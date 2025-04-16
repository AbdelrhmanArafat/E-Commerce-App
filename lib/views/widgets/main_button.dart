import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool hasCircleBorder;

  const MainButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.hasCircleBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: hasCircleBorder
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                )
              : null,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
