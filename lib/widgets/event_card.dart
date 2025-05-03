import 'dart:io';
import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  //   @override
  //   Widget build(BuildContext context) {
  //     return ListTile(
  //       leading:
  //           event.eventImagePath != null
  //               ? ClipRRect(
  //                 borderRadius: BorderRadius.circular(8),
  //                 child: Image.file(
  //                   File(event.eventImagePath!),
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               )
  //               : const Icon(Icons.event),
  //       title: Text(event.eventName),
  //       subtitle: Text(
  //         DateFormat('dd MMM yyyy – HH:mm').format(event.eventDateTime),
  //       ),
  //       onTap: () {
  //         // Naar event detailpagina navigeren (later)
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap event (e.g., navigate to event details)
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
