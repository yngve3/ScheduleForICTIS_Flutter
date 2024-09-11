import 'package:flutter/material.dart';
import 'package:schedule_for_ictis_flutter/data/repositories/events_repository.dart';
import 'package:schedule_for_ictis_flutter/data/repositories/reminders_repository.dart';
import 'package:schedule_for_ictis_flutter/data/repositories/user_repository.dart';
import 'package:schedule_for_ictis_flutter/presentation/extensions/date_time_ext.dart';
import 'package:schedule_for_ictis_flutter/utils/reminders_helper.dart';

import '../../data/models/event_db.dart';
import '../../utils/state_list.dart';
import '../models/reminder/reminder.dart';
import '../models/schedule/day_schedule_item.dart';

class EventsInteractor {
  final EventsRepository _eventsRepository = EventsRepository();
  final RemindersRepository _remindersRepository = RemindersRepository();
  final UserRepository _userRepository = UserRepository();

  void addEvent({
    int? id,
    required TimeOfDay timeStart,
    required TimeOfDay timeEnd,
    required DateTime date,
    required String title,
    String? description,
    String? location,
    required StateList<Reminder> reminders,
  }) async {
    final remindersList = _remindersRepository.processReminders(reminders,
      isEdit: id != null,
      title: title,
      dateTime: DateTime(date.year, date.month, date.day, timeStart.hour, timeStart.minute)
    );

    final eventDB = EventDB(
      id: id ?? 0,
      title: title,
      dateTimeStart: DateTime(date.year, date.month, date.day, timeStart.hour, timeStart.minute),
      dateTimeEnd: DateTime(date.year, date.month, date.day, timeEnd.hour, timeEnd.minute),
      weekNum: date.weekNumber,
      location: toNullIfEmpty(location),
      description: toNullIfEmpty(description),
      reminders: remindersList,
      userUID: _userRepository.uid ?? ""
    );

    _eventsRepository.addEvent(eventDB);
  }

  Event? getEventById(int id) {
    final eventDB = _eventsRepository.getEventById(id);
    if (eventDB == null) return null;
    return Event.fromEventDB(eventDB);
  }

  void deleteEvent(int id, List<Reminder>? reminders) {
    _eventsRepository.deleteEvent(id);
    final deletedRemindersIds = reminders?.map((e) => e.id!).toList();
    RemindersHelper.deleteReminders(deletedRemindersIds ?? []);
  }

  String? toNullIfEmpty(String? string) {
    if (string == null) return null;
    if (string.isEmpty) return null;
    return string;
  }
}

