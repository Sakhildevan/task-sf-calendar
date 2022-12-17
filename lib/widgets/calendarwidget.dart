import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todo/provider/event_provider.dart';
import 'package:todo/widgets/task_widget.dart';
import '../model/event_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Future<DateTime> initialDate = getDateFromLocalStorage();
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      //initialSelectedDate: initialDate,
      dataSource: EventDataSource(events),
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: ((context) => TaskWidget()),
        );
      },
      selectionDecoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Color.fromARGB(255, 218, 20, 168), width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        shape: BoxShape.rectangle,
      ),
      todayHighlightColor: Colors.red,
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Color.fromARGB(0, 255, 255, 255),
    );
  }

  // Future<DateTime> getDateFromLocalStorage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // assume that the date is stored as a string in the format "yyyy-MM-dd"
  //   String? dateString = prefs.getString("date");
  //   if (dateString == null) {
  //     // if the date is not found in local storage, return the current date
  //     return DateTime.now();
  //   }
  //   // parse the date string and return the DateTime object
  //   return DateTime.parse(dateString);
  // }
}
