import 'package:eventcountdown/pages/edit_event_screen.dart';
import 'package:eventcountdown/utilities/app_navigator.dart';
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
            // HomePage zonder animatie op start
            if (settings.name == '/') {
              return MaterialPageRoute(
                builder: (_) => const HomePage(),
                settings: settings,
              );
            }

            // Andere routes worden via AppNavigator aangemaakt
            return AppNavigator.createRoute(
              settings.name!,
              arguments: settings.arguments,
            );
          },
        );
      },
    );
  }
}
