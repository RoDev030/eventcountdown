import 'package:flutter/material.dart';

class ConfirmOnPop extends StatelessWidget {
  final Widget child;
  final bool Function() hasChanges;

  const ConfirmOnPop({
    super.key,
    required this.child,
    required this.hasChanges,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (hasChanges()) {
          final shouldDiscard = await showDialog<bool>(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Discard Changes?'),
                  content: const Text(
                    'Are you sure you want to discard your changes?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Discard'),
                    ),
                  ],
                ),
          );

          if (shouldDiscard == true) {
            Navigator.of(context).pop(); // Go back to previous screen.
          }
        } else {
          Navigator.of(context).pop(); // Go back to previous screen.
        }
      },
      child: child,
    );
  }
}
