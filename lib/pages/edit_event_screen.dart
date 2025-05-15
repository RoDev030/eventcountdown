import 'package:eventcountdown/utilities/pop_scope.dart';
import 'package:eventcountdown/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:eventcountdown/widgets/event_form.dart';
import 'package:eventcountdown/widgets/event_image_picker.dart';
import 'package:eventcountdown/widgets/event_submit_button.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../models/event_database.dart';

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
      text: widget.event.eventDateTime.toLocal().toString().split(' ')[0],
    );
    _timeController = TextEditingController(); // ← tijdelijk leeg

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

    // hier mag je veilig context gebruiken
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
      // Combine date and time into DateTime
      final dateParts = _dateController.text.split('-');
      final timeParts = _timeController.text.split(':');
      final parsedDateTime = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );

      final updatedEvent = Event(
        id: widget.event.id, // belangrijk!
        eventName: _nameController.text,
        eventDateTime: parsedDateTime,
        eventLocation: _locationController.text,
        eventDescription: _descriptionController.text,
        eventImagePath: _eventImagePath,
      );

      Provider.of<EventDatabase>(
        context,
        listen: false,
      ).updateEvent(updatedEvent);
      Navigator.pop(context);
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
        bottomNavigationBar: CustomBottomNavBar(),
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
