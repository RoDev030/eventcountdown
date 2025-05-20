import 'package:eventcountdown/utilities/pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:eventcountdown/widgets/events/event_form.dart';
import 'package:eventcountdown/widgets/events/event_image_picker.dart';
import 'package:eventcountdown/widgets/events/event_submit_button.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../models/event_database.dart';
import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  String? _eventImagePath;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.event.eventName);
    _dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(widget.event.eventDateTime),
    );
    _timeController = TextEditingController();

    _locationController = TextEditingController(
      text: widget.event.eventLocation,
    );
    _descriptionController = TextEditingController(
      text: widget.event.eventDescription,
    );
    _eventImagePath = widget.event.eventImagePath;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _timeController.text = TimeOfDay.fromDateTime(
      widget.event.eventDateTime,
    ).format(context);
  }

  bool hasChanges() {
    return _nameController.text != widget.event.eventName ||
        _dateController.text !=
            widget.event.eventDateTime.toLocal().toString().split(' ')[0] ||
        _timeController.text !=
            TimeOfDay.fromDateTime(
              widget.event.eventDateTime,
            ).format(context) ||
        _locationController.text != widget.event.eventLocation ||
        _descriptionController.text != widget.event.eventDescription ||
        _eventImagePath != widget.event.eventImagePath;
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      try {
        final date = DateFormat('dd-MM-yyyy').parse(_dateController.text);
        final time = _parseFlexibleTime(_timeController.text);
        final combinedDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        final updatedEvent = Event(
          id: widget.event.id,
          eventName: _nameController.text,
          eventDateTime: combinedDateTime,
          eventLocation: _locationController.text,
          eventDescription: _descriptionController.text,
          eventImagePath: _eventImagePath,
        );

        Provider.of<EventDatabase>(
          context,
          listen: false,
        ).updateEvent(updatedEvent);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ongeldig tijd- of datumformaat")),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConfirmOnPop(
      hasChanges: hasChanges,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Bewerk Event"),
          actions: [
            IconButton(icon: const Icon(Icons.check), onPressed: _saveChanges),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                EventForm(
                  nameController: _nameController,
                  dateController: _dateController,
                  timeController: _timeController,
                  locationController: _locationController,
                  descriptionController: _descriptionController,
                ),
                const SizedBox(height: 12),
                EventImagePicker(
                  eventImagePath: _eventImagePath,
                  onImageSelected: (imagePath) {
                    setState(() {
                      _eventImagePath = imagePath;
                    });
                  },
                ),
                const SizedBox(height: 12),
                EventSubmitButton(
                  formKey: _formKey,
                  nameController: _nameController,
                  dateController: _dateController,
                  timeController: _timeController,
                  locationController: _locationController,
                  descriptionController: _descriptionController,
                  eventImagePath: _eventImagePath,
                  onPressed: _saveChanges,
                  buttonLabel: 'Opslaan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

DateTime _parseFlexibleTime(String timeString) {
  final formats = [DateFormat('HH:mm'), DateFormat('h:mm a')];
  for (final format in formats) {
    try {
      return format.parse(timeString);
    } catch (_) {}
  }
  throw FormatException('Geen geldig tijdformaat: $timeString');
}
