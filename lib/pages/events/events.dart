import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssssssssss/models/event_model.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late Future<List<EventModel>> events;
  late SharedPreferences _prefs;
  FilterType _selectedFilter = FilterType.all;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePrefs();
  }

  void initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      events = _getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Event List'),),
      ),
      body: Column(
        children: [
          _getFilterButtons(),
          FutureBuilder(
            future: events, 
            builder:(context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'),);
              }

              if (snapshot.hasData) {
                List<EventModel> data = snapshot.data as List<EventModel>;
                var filteredData = _filterEvents(data);
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder:(context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            _prefs.setBool('${filteredData[index].eventId}_read', true);
                            var prevViews = _prefs.getInt('${filteredData[index].eventId}_view') ?? 0;
                            _prefs.setInt('${filteredData[index].eventId}_view', prevViews + 1);
                            setState(() {
                              
                            });
                            Navigator.pushNamed(context, '/eventDetails', arguments: filteredData[index]);
                          },
                          title: Column(
                            children: [
                              Text(
                                '${filteredData[index].eventTitle}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${filteredData[index].eventText}',
                                maxLines: 2,
                              ),
                              _getReadStatus(filteredData[index]),
                            ],
                          ),
                          leading: Image.asset('assets/events_resources/images/${filteredData[index].eventPictures?[0]}', width: 150, height: 150,),
                        ),
                      );
                    },
                  ),
                );
              }

              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }

  Future<List<EventModel>> _getEvents() async {
    var jsondata = await rootBundle.loadString('assets/events_resources/json/events_data.json');
    var list = json.decode(jsondata) as List<dynamic>;
    var listEvent = list.map((e) => EventModel.fromJson(e)).toList();
    List<EventModel> updatedList = listEvent.map((value) {
      if (_prefs.getBool('${value.eventId}_read') == true) {
        value.eventReadStatus = true;
      } else {
        value.eventReadStatus = false;
      }
      return value;
    }).toList();

    return updatedList;
  }

  Widget _getReadStatus(EventModel event) {
    var isRead = _prefs.getBool('${event.eventId}_read') == true;

    if (isRead) {
      return Text('Read');
    } else {
      return Text('Unread');
    }
  }

  List<EventModel> _filterEvents(List<EventModel> events) {
    switch (_selectedFilter) {
      case FilterType.all:
        return events;
      case FilterType.read:
        return events.where((element) => _prefs.getBool('${element.eventId}_read') == true).toList();
      case FilterType.unread:
        return events.where((element) => (_prefs.getBool('${element.eventId}_read') ?? false) == false).toList();
    }
  }

  Widget _getFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              _selectedFilter = FilterType.all;
            });
          }, 
          child: Text('All')
        ),
        Text(' / '),
        TextButton(
          onPressed: () {
            setState(() {
              _selectedFilter = FilterType.read;
            });
          }, 
          child: Text('Read')
        ),
        Text(' / '),
        TextButton(
          onPressed: () {
            setState(() {
              _selectedFilter = FilterType.unread;
            });
          }, 
          child: Text('Unread')
        ),
      ],
    );
  }
}

enum FilterType {
  all,
  read,
  unread,
}