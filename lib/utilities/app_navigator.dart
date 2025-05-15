import 'package:eventcountdown/models/event.dart';
import 'package:eventcountdown/pages/add_event_screen.dart';
import 'package:eventcountdown/pages/edit_event_screen.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static Future<void> push(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) async {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    // Als we naar dezelfde route proberen te navigeren: doe niets
    if (currentRoute == routeName) {
      return;
    }

    await Navigator.of(
      context,
    ).push(createRoute(routeName, arguments: arguments));
  }

  static Future<void> pushReplacement(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) async {
    await Navigator.of(
      context,
    ).pushReplacement(createRoute(routeName, arguments: arguments));
  }

  static Route createRoute(String routeName, {Object? arguments}) {
    Widget page;

    switch (routeName) {
      case '/':
        page = const Placeholder(); // Wordt overschreven in main.dart
        break;
      case '/add_event_screen':
        page = const AddEventScreen();
        break;
      case '/edit_event_screen':
        final event = arguments as Event;
        page = EditEventScreen(event: event);
        break;
      default:
        page = const Placeholder();
    }

    return PageRouteBuilder(
      settings: RouteSettings(name: routeName, arguments: arguments),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, __) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeInOut));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
