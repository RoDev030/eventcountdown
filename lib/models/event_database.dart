import 'package:hive_flutter/hive_flutter.dart';
import 'event.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class EventDatabase extends ChangeNotifier {
  late Box<Event> eventBox;

  EventDatabase() {
    eventBox = Hive.box<Event>('events');
    getEvents();
  }

  //List of events
  final List<Event> events = [];

  //Create
  Future<void> addEvent(
    String eventName,
    DateTime eventDateTime,
    String eventLocation,
    String eventDescription, {
    String? eventImagePath,
  }) async {
    final event = Event(
      id: const Uuid().v4(),
      eventName: eventName,
      eventDateTime: eventDateTime,
      eventLocation: eventLocation,
      eventDescription: eventDescription,
      eventImagePath: eventImagePath,
    );
    await eventBox.put(event.id, event);
    await getEvents();
  }

  //Read
  Future<List<Event>> getEvents() async {
    events.clear();
    events.addAll(eventBox.values);
    notifyListeners();
    return events;
  }

  //Update
  Future<void> updateEvent(Event updatedEvent) async {
    await eventBox.put(updatedEvent.id, updatedEvent);
    await getEvents();
  }

  //Delete
  Future<void> deleteEvent(Event event) async {
    await eventBox.delete(event.id);
    await getEvents();
  }

  ValueListenable<Box<Event>> listenToEvents() {
    return eventBox.listenable();
  }
}
