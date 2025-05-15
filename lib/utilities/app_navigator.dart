import 'package:eventcountdown/models/event.dart';
import 'package:eventcountdown/pages/add_event_screen.dart';
import 'package:eventcountdown/pages/edit_event_screen.dart';
import 'package:eventcountdown/pages/homepage.dart';
import 'package:eventcountdown/pages/settingspage.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static Future<void> navigateTo(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) async {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    // Als we naar dezelfde route proberen te navigeren: sluit de drawer
    if (currentRoute == routeName) {
      return;
    }

    // Navigeren met animatie
    await Navigator.of(
      context,
    ).push(createRoute(routeName, arguments: arguments));
  }

  static Route createRoute(String routeName, {Object? arguments}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName, arguments: arguments),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, __) => _getPage(routeName, arguments),
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

  static Widget _getPage(String routeName, Object? arguments) {
    switch (routeName) {
      case '/':
        return const HomePage();
      case '/add_event_screen':
        return const AddEventScreen();
      case '/edit_event_screen':
        final event = arguments as Event;
        return EditEventScreen(event: event);
      case '/settings':
        return const SettingsPage(); // Voeg hier je instellingenpagina toe
      default:
        return const Placeholder(); // Fallback voor onbekende routes
    }
  }
}
