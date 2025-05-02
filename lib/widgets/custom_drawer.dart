import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _buildItem(
            icon: Icons.home_filled,
            title: "Home",
            onTap: () => Navigator.of(context).pushNamed("/"),
          ),
          _buildItem(
            icon: Icons.settings,
            title: "Settings",
            onTap: () => Navigator.of(context).pushNamed("/"),
          ),
          _buildItem(
            icon: Icons.add,
            title: "Add Event",
            onTap: () => Navigator.of(context).pushNamed("/add_event_screen"),
          ),
          // _buildItem(
          //   icon: Icons.add,
          //   title: "Add Event",
          //   onTap: () => Navigator.of(context).pushNamed("/add_event_screen"),
          // ),
          SwitchListTile(
            title: const Text("Donkere modus"),
            value: context.watch<ThemeProvider>().isDarkMode,
            onChanged: (value) => context.read<ThemeProvider>().toggleTheme(),
          ),
        ],
      ),
    );
  }

  _buildItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}
