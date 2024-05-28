import 'package:flutter/material.dart';
import 'package:wssssssssss/pages/tickets/ticket_details.dart';
import 'package:wssssssssss/pages/tickets/tickets.dart';

GlobalKey<NavigatorState> ticketNavKey = GlobalKey<NavigatorState>();

class TicketsNav extends StatelessWidget {
  const TicketsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: ticketNavKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder:(context) {
            if (settings.name == '/ticketDetails') {
              return TicketDetails();
            }

            return Tickets();
          },
        );
      },
    );
  }
}