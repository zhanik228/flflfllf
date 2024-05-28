import 'package:flutter/material.dart';

class Tickets extends StatelessWidget {
  const Tickets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Tickets List'),),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ticketCreate');
            }, 
            child: Text('Create a new ticket'),
          )
        ],
      ),
    );
  }
}