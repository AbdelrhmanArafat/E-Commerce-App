import 'package:flutter/material.dart';

class HeaderOfList extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String description;

  const HeaderOfList({
    super.key,
    required this.title,
    this.onTap,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ],
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }
}
