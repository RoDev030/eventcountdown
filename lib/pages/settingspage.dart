import 'package:eventcountdown/themes/theme_provider.dart';
import 'package:eventcountdown/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      body: Center(
        child: Column(
          children: [
            Text('Settings'),
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
