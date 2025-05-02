import 'package:flutter/material.dart';
import '../models/event_database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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

  DateTime parseFlexibleTime(String timeString) {
    final List<DateFormat> formats = [
      DateFormat('h:mm a'), // 12h formaat
      DateFormat('HH:mm'), // 24h formaat
    ];

    for (final format in formats) {
      try {
        return format.parse(timeString);
      } catch (_) {
        continue;
      }
    }

    throw FormatException('Geen geldig tijdformaat: $timeString');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            final eventDatabase = Provider.of<EventDatabase>(
              context,
              listen: false,
            );

            final selectedDate = DateFormat(
              'dd-MM-yyyy',
            ).parse(dateController.text);
            final parsedTime = parseFlexibleTime(timeController.text);
            ;
            final selectedTime = TimeOfDay.fromDateTime(parsedTime);

            final fullDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            await eventDatabase.addEvent(
              nameController.text,
              fullDateTime,
              locationController.text,
              descriptionController.text,
              eventImagePath: eventImagePath,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Event added successfully")),
            );
            Navigator.pop(context);
          }
        },
        child: const Text("Add Event"),
      ),
    );
  }
}
