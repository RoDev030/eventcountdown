import 'package:flutter/material.dart';
import '../database/event_database.dart';
import '/utilities/drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool hasChanges() {
    return _nameController.text.isNotEmpty ||
        _dateController.text.isNotEmpty ||
        _timeController.text.isNotEmpty ||
        _locationController.text.isNotEmpty ||
        _descriptionController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    //add warning if user tries to leave without saving
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        if (hasChanges()) {
          final shouldDiscard = await showDialog<bool>(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Discard changes?'),
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
      //Form for adding event
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("Add Event"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  maxLength: 75,

                  decoration: InputDecoration(
                    counterText: "",
                    labelText: "Event Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            _dateController.text = DateFormat(
                              'dd-MM-yyyy',
                            ).format(pickedDate);
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Event Date",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a date';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 12),

                    Expanded(
                      child: TextFormField(
                        controller: _timeController,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null && mounted) {
                            _timeController.text = pickedTime.format(context);
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Event Time",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a time';
                          }
                          return null;
                        },
                      ),
                    ),
                    FittedBox(),
                  ],
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: "Event Location",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  maxLength: 300,
                  decoration: InputDecoration(
                    counterText: "",
                    labelText: "Event Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      final eventDatabase = Provider.of<EventDatabase>(
                        context,
                        listen: false,
                      );

                      final DateTime selectedDate = DateFormat(
                        'dd-MM-yyyy',
                      ).parse(_dateController.text);
                      final TimeOfDay selectedTime = TimeOfDay(
                        hour: int.parse(_timeController.text.split(":")[0]),
                        minute: int.parse(_timeController.text.split(":")[1]),
                      );

                      final DateTime fullDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );

                      await eventDatabase.addEvent(
                        _nameController.text,
                        fullDateTime,
                        _locationController.text,
                        _descriptionController.text,
                      );

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Event added succesfully"),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text("Add Event"),
                  //icon: add_photo_alternate_outlined
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
