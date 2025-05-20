import 'package:flutter/material.dart';
import '../../utilities/submit_event.dart';

class EventSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final String? eventImagePath;
  final VoidCallback? onPressed;
  final String buttonLabel;

  const EventSubmitButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.dateController,
    required this.timeController,
    required this.locationController,
    required this.descriptionController,
    required this.eventImagePath,
    this.onPressed,
    this.buttonLabel = "Add Event",
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor:
            Theme.of(context).colorScheme.onPrimary, // tekst & icon kleur
        backgroundColor:
            Theme.of(context).colorScheme.primary, // achtergrondkleur
      ),
      onPressed:
          onPressed ??
          () {
            FocusManager.instance.primaryFocus?.unfocus();
            submitEvent(
              context: context,
              formKey: formKey,
              nameController: nameController,
              dateController: dateController,
              timeController: timeController,
              locationController: locationController,
              descriptionController: descriptionController,
              eventImagePath: eventImagePath,
            );
          },
      child: Text(buttonLabel),
    );
  }
}
