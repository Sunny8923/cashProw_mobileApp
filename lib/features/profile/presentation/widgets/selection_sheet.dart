import 'package:flutter/material.dart';

class SelectSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const SelectSheet({
    super.key,
    required this.title,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),

        ...options.map(
          (e) => ListTile(
            title: Text(e),
            onTap: () {
              onSelected(e);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
