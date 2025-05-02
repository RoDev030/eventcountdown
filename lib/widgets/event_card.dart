import 'dart:io';
import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          event.eventImagePath != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(event.eventImagePath!),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              )
              : const Icon(Icons.event),
      title: Text(event.eventName),
      subtitle: Text(
        DateFormat('dd MMM yyyy – HH:mm').format(event.eventDateTime),
      ),
      onTap: () {
        // Naar event detailpagina navigeren (later)
      },
    );
  }
}
