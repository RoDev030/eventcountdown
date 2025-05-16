import 'dart:io';
import 'package:eventcountdown/models/event_database.dart';
import 'package:eventcountdown/pages/edit_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../models/event.dart';
import 'package:provider/provider.dart';

class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(widget.event.eventName),
                content: Text(widget.event.eventDescription),
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
                      Navigator.of(context).pop(); // sluit het dialoog
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => EditEventScreen(event: widget.event),
                        ),
                      );
                    },
                    child: const Text('Edit'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle delete action
                      Provider.of<EventDatabase>(
                        context,
                        listen: false,
                      ).deleteEvent(widget.event);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
        );
      },
      child: buildEventCard(widget.event),
    );
  }

  Widget buildEventCard(Event event) {
    return Container(
      width: 340,
      height: 200,
      decoration: BoxDecoration(
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  event.eventName,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
                const SizedBox(height: 8),
                SlideCountdown(
                  duration: Duration(
                    days: event.eventDateTime.difference(DateTime.now()).inDays,
                    hours: event.eventDateTime
                        .difference(DateTime.now())
                        .inHours
                        .remainder(24),
                    minutes: event.eventDateTime
                        .difference(DateTime.now())
                        .inMinutes
                        .remainder(60),
                    seconds: event.eventDateTime
                        .difference(DateTime.now())
                        .inSeconds
                        .remainder(60),
                  ),
                  separatorType: SeparatorType.title,
                  slideDirection: SlideDirection.up,
                  separatorStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
