import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/Utils.dart';
import 'package:todo/model/event.dart';
import 'package:todo/page/event_editing.dart';
import 'package:todo/provider/event_provider.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;
  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildViewingActions(context, event),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
            buildDateTime(event),
            SizedBox(height: 32),
            Text(
              event.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              event.description,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        ),
      );

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(
          event.isAllDay ? 'All-day' : 'From',
          event.from,
        ),
        if (!event.isAllDay) buildDate('To', event.to),
      ],
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    return [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => EventEditingPage(
            event: event,
          ),
        )),
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: (() {
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.deleteEvent(event);
        }),
      ),
    ];
    // ignore: dead_code
    throw Exception('Error: buildViewingActions did not complete normally');
  }

  Widget buildDate(String title, DateTime date) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          DateFormat.yMMMd().format(date),
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
