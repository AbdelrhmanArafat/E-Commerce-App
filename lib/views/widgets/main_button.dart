import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String? text;
  final bool hasCircleBorder;
  final VoidCallback? onPressed;
  final Widget? child;

  MainButton({
    super.key,
    this.onPressed,
    this.text,
    this.hasCircleBorder = false,
    this.child,
  }) {
    assert(text != null || child != null);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: hasCircleBorder
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                )
              : null,
        ),
        child: text != null ? Text(text!) : child,
      ),
    );
  }
}
