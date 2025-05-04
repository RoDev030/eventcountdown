import 'dart:io';
import 'package:eventcountdown/models/event_database.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(event.eventName),
                content: Text(event.eventDescription),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Handle view details action
                      Navigator.of(context).pop();
                    },
                    child: const Text('View Details'),
                  ),
                ],
              ),
        );
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Event Options'),
                content: const Text('Edit or delete this event.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Handle edit action
                      Navigator.of(context).pop();
                    },
                    child: const Text('Edit'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle delete action
                      Provider.of<EventDatabase>(
                        context,
                        listen: false,
                      ).deleteEvent(event);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
        );
      },
      child: buildEventCard(event),
    );
  }

  Widget buildEventCard(Event event) {
    return Container(
      width: 340,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image:
            event.eventImagePath != null &&
                    File(event.eventImagePath!).existsSync()
                ? DecorationImage(
                  image: FileImage(
                    File(event.eventImagePath!),
                  ), // Use FileImage for local files
                  fit: BoxFit.cover,
                )
                : DecorationImage(
                  image: AssetImage('assets/defaultimage.jpg'),
                  fit: BoxFit.cover,
                ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            event.eventName,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            event.eventDateTime.toString(),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
