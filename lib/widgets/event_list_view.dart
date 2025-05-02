import 'package:flutter/material.dart';
import '../models/event.dart';
import 'event_card.dart';

class EventListView extends StatelessWidget {
  final List<Event> events;

  const EventListView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventCard(event: event);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
