import 'package:flutter/material.dart';
import 'pages/add_event_screen.dart';
import 'package:provider/provider.dart';
import 'models/event_database.dart';
import 'themes/theme_provider.dart';
import 'pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // verplicht bij async main

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
          routes: {
            '/': (context) => const HomePage(),
            '/add_event_screen': (context) => const AddEventScreen(),
            //'/settings_screen': (context) => const SettingsScreen(),
          },
        );
      },
    );
  }
}
