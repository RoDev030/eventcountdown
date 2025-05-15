import 'package:eventcountdown/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event_database.dart';
import '../widgets/event_page_view.dart';
import 'package:hive/hive.dart';
import '../models/event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventDatabase = Provider.of<EventDatabase>(context);

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      body: ValueListenableBuilder(
        valueListenable: eventDatabase.listenToEvents(),
        builder: (context, Box<Event> box, _) {
          final events = box.values.toList();

          if (events.isEmpty) {
            return const Center(child: Text('Nog geen events toegevoegd.'));
          }

          return EventPageView(events: events);
        },
      ),
    );
  }
}
