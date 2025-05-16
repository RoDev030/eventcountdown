import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/event_database.dart';

Future<void> submitEvent({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController nameController,
  required TextEditingController dateController,
  required TextEditingController timeController,
  required TextEditingController locationController,
  required TextEditingController descriptionController,
  String? eventImagePath,
  VoidCallback? onSuccess, // <-- Toegevoegd
}) async {
  if (!formKey.currentState!.validate()) return;

  final eventDatabase = Provider.of<EventDatabase>(context, listen: false);

  final selectedDate = DateFormat('dd-MM-yyyy').parse(dateController.text);
  final parsedTime = _parseFlexibleTime(timeController.text);
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

  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text("Event toegevoegd!")));

  if (onSuccess != null) {
    onSuccess();
  }
}

DateTime _parseFlexibleTime(String timeString) {
  final formats = [DateFormat('h:mm a'), DateFormat('HH:mm')];

  for (final format in formats) {
    try {
      return format.parse(timeString);
    } catch (_) {}
  }

  throw FormatException('Geen geldig tijdformaat: $timeString');
}
