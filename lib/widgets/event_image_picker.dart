import 'package:flutter/material.dart';
import 'package:eventcountdown/methods/image_picker.dart';
import 'dart:io';

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
        Row(
          children: [
            Text('\t \t Selecteer \n achtergrond'),
            SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  final image = await pickImage();
                  if (image != null) {
                    onImageSelected(image);
                  } else {
                    debugPrint('No image selected.');
                  }
                } catch (e) {
                  debugPrint('Error picking image: $e');
                }
              },
              child: const Icon(Icons.add_photo_alternate_outlined),
            ),
          ],
        ),
        if (eventImagePath != null && File(eventImagePath!).existsSync()) ...[
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
        ] else if (eventImagePath != null) ...[
          const SizedBox(height: 12),
          const Text(
            'Afbeelding niet gevonden of ongeldig pad.',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }
}
