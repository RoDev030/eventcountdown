import 'package:flutter/material.dart';
import '../utilities/submit_event.dart';

class EventSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final String? eventImagePath;

  const EventSubmitButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.dateController,
    required this.timeController,
    required this.locationController,
    required this.descriptionController,
    required this.eventImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          () => submitEvent(
            context: context,
            formKey: formKey,
            nameController: nameController,
            dateController: dateController,
            timeController: timeController,
            locationController: locationController,
            descriptionController: descriptionController,
            eventImagePath: eventImagePath,
          ),
      child: const Text("Add Event"),
    );
  }
}
