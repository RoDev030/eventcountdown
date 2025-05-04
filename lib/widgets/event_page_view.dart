import 'package:flutter/material.dart';
import '../models/event.dart';
import 'event_card.dart';

class EventPageView extends StatelessWidget {
  final List<Event> events;

  const EventPageView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventCard(event: event);
      },
    );
  }
}
