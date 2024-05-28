import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wssssssssss/navigation/event_nav.dart';
import 'package:wssssssssss/navigation/tickets_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    eventNavKey,
    ticketNavKey
  ];

  Future<bool> _onBackButtonPressed() async {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex].currentState
        ?.pop(_navigatorKeys[_selectedIndex].currentContext);

      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true;
    }
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Records',
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            EventsNav(),
            TicketsNav(),
          ],
        ),
      ),
    );
  }
}