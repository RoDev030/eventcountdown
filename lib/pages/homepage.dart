import 'package:eventcountdown/utilities/drawer.dart';
import 'package:eventcountdown/widgets/custom_app_bar.dart';
import 'package:eventcountdown/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:eventcountdown/methods/image_picker.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Countdown App"),
      drawer: CustomDrawer(),
      floatingActionButton: CustomFloatingActionButton(
        routeName: "/add_event_screen",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image:
              //         backgroundImage != null
              //             ? FileImage(backgroundImage)
              //             : const AssetImage(
              //                   'assets/images/default_background.jpg',
              //                 )
              //                 as ImageProvider,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              margin: const EdgeInsets.all(4),
              height: 100,
              width: 100,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
