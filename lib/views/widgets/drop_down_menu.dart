import 'package:flutter/material.dart';

class DropDownMenuComponent extends StatelessWidget {
  final List<String> items;
  final Function(String? value) onChanged;
  final String hint;

  const DropDownMenuComponent({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: null,
      elevation: 16,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      style: Theme.of(context).textTheme.titleLarge,
      hint: FittedBox(child: Text(hint)),
      items: items.map(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      onChanged: onChanged,
    );
  }
}
