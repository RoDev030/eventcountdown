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
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/");
            },
          ),
          _buildItem(
            icon: Icons.settings,
            title: "Settings",
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/");
            },
          ),
          _buildItem(
            icon: Icons.add,
            title: "Add Event",
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/add_event_screen");
            },
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

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
