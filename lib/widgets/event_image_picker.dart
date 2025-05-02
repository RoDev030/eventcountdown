import 'package:flutter/material.dart';
import 'package:eventcountdown/methods/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class EventImagePicker extends StatelessWidget {
  final String? eventImagePath;
  final Function(String) onImageSelected;

  const EventImagePicker({
    Key? key,
    required this.eventImagePath,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final image = await pickImage();
            if (image != null) {
              onImageSelected(image);
            }
          },
          child: const Icon(Icons.add_photo_alternate_outlined),
        ),
        if (eventImagePath != null) ...[
          const SizedBox(height: 12),
          const Text(
            'Gekozen afbeelding:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Image.file(
            File(eventImagePath!),
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }
}
