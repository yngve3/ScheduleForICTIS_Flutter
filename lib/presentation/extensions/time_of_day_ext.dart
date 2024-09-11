import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {

  static TimeOfDay parse(String time) {
    final timeSplit = time.split(':');
    final hour = int.parse(timeSplit[0]);
    final minute = int.parse(timeSplit[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  String get string {
    return "$hour:$minute";
  }

  TimeOfDay plus(TimeOfDay timeOfDay) {
    return TimeOfDay(hour: hour + timeOfDay.hour, minute: minute + timeOfDay.minute);
  }

  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }
}
