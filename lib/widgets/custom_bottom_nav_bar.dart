import 'package:flutter/material.dart';
import '../utilities/app_navigator.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Event'),
      ],
      currentIndex: 0, // Set the current index based on your logic
      onTap: (index) {
        switch (index) {
          case 0:
            AppNavigator.navigateTo(context, "/");
            break;
          case 1:
            AppNavigator.navigateTo(context, "/settings");
            break;
          case 2:
            AppNavigator.navigateTo(context, "/add_event_screen");
            break;
        }
      },
    );
  }
}
//       child: ListView(
//         children: [
//           _buildItem(
//             icon: Icons.home_filled,
//             title: "Home",
//             onTap: () {
//               AppNavigator.navigateTo(
//                 context,
//                 "/",
//               ); // Gebruik alleen AppNavigator
//             },
//           ),
//           _buildItem(
//             icon: Icons.settings,
//             title: "Settings",
//             onTap: () {
//               Navigator.pop(context);
//               AppNavigator.navigateTo(
//                 context,
//                 "/",
//               ); // Stel een route in voor instellingen
//             },
//           ),
//           _buildItem(
//             icon: Icons.add,
//             title: "Add Event",
//             onTap: () {
//               Navigator.pop(context);
//               AppNavigator.navigateTo(context, "/add_event_screen");
//             },
//           ),
//           SwitchListTile(
//             title: const Text("Donkere modus"),
//             value: context.watch<ThemeProvider>().isDarkMode,
//             onChanged: (value) => context.read<ThemeProvider>().toggleTheme(),
//           ),
//         ],
//       ),
//     );
//   }

//   _buildItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
//   }
// }
