import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String routeName;

  const CustomFloatingActionButton({
    super.key,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(routeName);
      },
      backgroundColor: colorScheme.primary,
      child: const Icon(Icons.add),
    );
  }
}