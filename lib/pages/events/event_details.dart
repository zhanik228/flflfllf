import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssssssssss/models/event_model.dart';
import 'package:wssssssssss/pages/events/event_image.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  late SharedPreferences _prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EventModel;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Event Details'),),
      ),
      body: Column(
        children: [
          Spacer(),
          Text(
            '${args.eventTitle}',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
          Text(
            '${_prefs.getInt('${args.eventId}_view') ?? 0}'
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap:() {
                  showDialog(context: context, builder: (_) => ImageDialog(path: '${args.eventPictures?[0]}'));
                },
                child: Image.asset(
                  'assets/events_resources/images/${args.eventPictures?[0]}',
                  width: 100,
                  height: 100,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap:() {
                  showDialog(context: context, builder: (_) => ImageDialog(path: '${args.eventPictures?[1]}'));
                },
                child: Image.asset(
                  'assets/events_resources/images/${args.eventPictures?[1]}',
                  width: 100,
                  height: 100,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap:() {
                  showDialog(context: context, builder: (_) => ImageDialog(path: '${args.eventPictures?[2]}'));
                },
                child: Image.asset(
                  'assets/events_resources/images/${args.eventPictures?[2]}',
                  width: 100,
                  height: 100,
                ),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          Text(
            '${args.eventText}'
          ),
          Spacer(),
        ],
      ),
    );
  }
}