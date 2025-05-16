import 'package:eventcountdown/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text("Donkere modus"),
              value: context.watch<ThemeProvider>().isDarkMode,
              onChanged: (value) => context.read<ThemeProvider>().toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
