import 'package:flutter/material.dart';

class SmallChoiceChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final void Function(bool)? onSelected;

  const SmallChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 2,
      ),
      labelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      label: label,
      selected: selected,
      onSelected: onSelected,
    );
  }
}
