import 'package:eventcountdown/utilities/pop_scope.dart';
import 'package:eventcountdown/utilities/submit_event.dart';
import 'package:flutter/material.dart';
import 'package:eventcountdown/widgets/events/event_form.dart';
import 'package:eventcountdown/widgets/events/event_image_picker.dart';
import 'package:eventcountdown/widgets/events/event_submit_button.dart';

class AddEventScreen extends StatefulWidget {
  final VoidCallback? onEventAdded; // <-- Toegevoegd
  const AddEventScreen({super.key, this.onEventAdded});

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

  String? _eventImagePath;

  bool hasChanges() {
    return _nameController.text.isNotEmpty ||
        _dateController.text.isNotEmpty ||
        _timeController.text.isNotEmpty ||
        _locationController.text.isNotEmpty ||
        _descriptionController.text.isNotEmpty ||
        _eventImagePath != null;
  }

  void _clearForm() {
    _nameController.clear();
    _dateController.clear();
    _timeController.clear();
    _locationController.clear();
    _descriptionController.clear();
    setState(() {
      _eventImagePath = null;
    });
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
          title: const Text("New Event"),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed:
                  () => submitEvent(
                    context: context,
                    formKey: _formkey,
                    nameController: _nameController,
                    dateController: _dateController,
                    timeController: _timeController,
                    locationController: _locationController,
                    descriptionController: _descriptionController,
                    eventImagePath: _eventImagePath,
                    onSuccess: () {
                      _clearForm(); // <-- Controllers legen
                      if (widget.onEventAdded != null) {
                        widget.onEventAdded!();
                      }
                    },
                  ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formkey,
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
                  formKey: _formkey,
                  nameController: _nameController,
                  dateController: _dateController,
                  timeController: _timeController,
                  locationController: _locationController,
                  descriptionController: _descriptionController,
                  eventImagePath: _eventImagePath,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    submitEvent(
                      context: context,
                      formKey: _formkey,
                      nameController: _nameController,
                      dateController: _dateController,
                      timeController: _timeController,
                      locationController: _locationController,
                      descriptionController: _descriptionController,
                      eventImagePath: _eventImagePath,
                      onSuccess: () {
                        _clearForm(); // <-- Controllers legen
                        if (widget.onEventAdded != null) {
                          widget.onEventAdded!();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
