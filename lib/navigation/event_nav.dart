import 'package:flutter/material.dart';
import 'package:wssssssssss/pages/events/event_details.dart';
import 'package:wssssssssss/pages/events/events.dart';

GlobalKey<NavigatorState> eventNavKey = GlobalKey<NavigatorState>();

class EventsNav extends StatelessWidget {
  const EventsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: eventNavKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder:(context) {
            if (settings.name == '/eventDetails') {
              return const EventDetails();
            }

            return const Events();
          },
        );
      },
    );
  }
}