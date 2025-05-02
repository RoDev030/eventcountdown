import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;

  const EventForm({
    Key? key,
    required this.nameController,
    required this.dateController,
    required this.timeController,
    required this.locationController,
    required this.descriptionController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          maxLength: 75,
          decoration: InputDecoration(
            counterText: "",
            labelText: "Event Name",
            labelStyle: TextStyle(color: Colors.grey),
            floatingLabelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            border: OutlineInputBorder(),
          ),
          validator:
              (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    dateController.text = DateFormat(
                      'dd-MM-yyyy',
                    ).format(pickedDate);
                  }
                },
                decoration: InputDecoration(
                  labelText: "Event Date",
                  labelStyle: TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value?.isEmpty ?? true ? 'Please enter a date' : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: timeController,
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    timeController.text = pickedTime.format(context);
                  }
                },
                decoration: InputDecoration(
                  labelText: "Event Time",
                  labelStyle: TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value?.isEmpty ?? true ? 'Please enter a time' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: locationController,
          decoration: InputDecoration(
            labelText: "Event Location",
            labelStyle: TextStyle(color: Colors.grey),
            floatingLabelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            border: OutlineInputBorder(),
          ),
          validator:
              (value) =>
                  value?.isEmpty ?? true ? 'Please enter a location' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: descriptionController,
          maxLength: 300,
          decoration: InputDecoration(
            counterText: "",
            labelText: "Event Description",
            labelStyle: TextStyle(color: Colors.grey),
            floatingLabelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            border: OutlineInputBorder(),
          ),
          validator:
              (value) =>
                  value?.isEmpty ?? true ? 'Please enter a description' : null,
        ),
      ],
    );
  }
}
