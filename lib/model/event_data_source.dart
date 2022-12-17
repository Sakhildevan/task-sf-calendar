import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todo/model/event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appoinments) {
    this.appointments = appointments;
  }
  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

  // @override
  // String getSubject(int index) => getEvent(index).description;
  @override
  Color getColor(int index) => getEvent(index).backgroungColor;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
