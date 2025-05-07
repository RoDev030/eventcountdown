import 'package:eventcountdown/pages/edit_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/add_event_screen.dart';
import 'package:provider/provider.dart';
import 'models/event_database.dart';
import 'themes/theme_provider.dart';
import 'pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Init Hive
  await Hive.initFlutter();
  Hive.registerAdapter(EventAdapter());
  await Hive.openBox<Event>('events');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => EventDatabase()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            Widget page;

            // Routing logica
            switch (settings.name) {
              case '/':
                page = const HomePage();
                break;
              case '/add_event_screen':
                page = const AddEventScreen();
                break;
              case '/edit_event_screen':
                final event = settings.arguments as Event;
                page = EditEventScreen(event: event);
                break;
              default:
                page = const HomePage(); // fallback
            }

            // Slide animatie voor álle routes
            return PageRouteBuilder(
              settings: settings,
              transitionDuration: const Duration(milliseconds: 300),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (_, animation, __) => page,
              transitionsBuilder: (_, animation, __, child) {
                const begin = Offset(1.0, 0.0); // slide vanaf rechts
                const end = Offset.zero;
                final tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: Curves.easeInOut));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          },
        );
      },
    );
  }
}
