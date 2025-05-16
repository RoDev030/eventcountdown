import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event_database.dart';
import '../widgets/events/event_page_view.dart';
import 'package:hive/hive.dart';
import '../models/event.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onAddEvent;
  const HomePage({super.key, this.onAddEvent});

  @override
  Widget build(BuildContext context) {
    final eventDatabase = Provider.of<EventDatabase>(context);

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: eventDatabase.listenToEvents(),
        builder: (context, Box<Event> box, _) {
          final events = box.values.toList();

          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'Geen events gevonden',
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(
                            context,
                          ).colorScheme.onPrimary, // tekst & icon kleur
                      backgroundColor:
                          Theme.of(
                            context,
                          ).colorScheme.primary, // achtergrondkleur
                    ),
                    onPressed: onAddEvent,
                    child: Text('Maak een event aan!'),
                  ),
                ],
              ),
            );
          }

          return EventPageView(events: events);
        },
      ),
    );
  }
}
