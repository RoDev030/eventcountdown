import 'package:flutter/material.dart';
import 'package:eventcountdown/widgets/event_form.dart';
import 'package:eventcountdown/widgets/event_image_picker.dart';
import 'package:eventcountdown/widgets/event_submit_button.dart';

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

  String? _eventImagePath;

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
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: Padding(
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
              EventImagePicker(
                eventImagePath: _eventImagePath,
                onImageSelected: (imagePath) {
                  setState(() {
                    _eventImagePath = imagePath;
                  });
                },
              ),
              EventSubmitButton(
                formKey: _formkey,
                nameController: _nameController,
                dateController: _dateController,
                timeController: _timeController,
                locationController: _locationController,
                descriptionController: _descriptionController,
                eventImagePath: _eventImagePath,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
