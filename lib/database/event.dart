import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class Event {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String eventName;

  @HiveField(2)
  final DateTime eventDateTime;

  @HiveField(3)
  final String eventLocation;

  @HiveField(4)
  final String eventDescription;


  Event({
    required this.id,
    required this.eventName,
    required this.eventDateTime,
    required this.eventLocation,
    required this.eventDescription,
  });
}