import 'package:eventcountdown/widgets/custom_app_bar.dart';
import 'package:eventcountdown/widgets/custom_drawer.dart';
import 'package:eventcountdown/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event_database.dart';
import '../widgets/event_list_view.dart';
import 'package:hive/hive.dart';
import '../models/event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventDatabase = Provider.of<EventDatabase>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Mijn Events'),
      drawer: CustomDrawer(),
      body: ValueListenableBuilder(
        valueListenable: eventDatabase.listenToEvents(),
        builder: (context, Box<Event> box, _) {
          final events = box.values.toList();

          if (events.isEmpty) {
            return const Center(child: Text('Nog geen events toegevoegd.'));
          }

          return EventListView(events: events);
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        routeName: '/add_event_screen',
      ),
    );
  }
}
