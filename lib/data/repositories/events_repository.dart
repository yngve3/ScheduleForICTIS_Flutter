import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:schedule_for_ictis_flutter/data/models/event_db.dart';
import 'package:schedule_for_ictis_flutter/data/repositories/user_repository.dart';
import 'package:schedule_for_ictis_flutter/domain/models/week_number/week_number.dart';
import 'package:schedule_for_ictis_flutter/main.dart';

import '../../objectbox.g.dart';

class EventsRepository {
  late final Box<EventDB> _eventsBox;
  late final DatabaseReference _ref;
  final UserRepository _userRepository = UserRepository(); //временно

  final _eventsController = StreamController<List<EventDB>>();
  Stream<List<EventDB>> get events => _eventsController.stream;

  EventsRepository() {
    _ref = FirebaseDatabase.instance.ref("users/${_userRepository.uid}/events/");
    _eventsBox = objectBox.store.box<EventDB>();
  }

  Future<void> loadEvents() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {

    }
  }

  void getEventsByWeekNum(WeekNumber weekNumber, String? userUID) {
    final query = _eventsBox.query(EventDB_.weekNum.equals(weekNumber.calendarWeekNumber).and(EventDB_.userUID.equals(userUID ?? "")));
    query.watch(triggerImmediately: true).forEach((event) => _eventsController.add(event.find()));
  }

  void getEventsAfter(DateTime dateTime, String? userUID) {
    final query = _eventsBox.query(EventDB_.dateTimeEnd.greaterThanDate(dateTime).and(EventDB_.userUID.equals(userUID ?? "")));
    query.watch(triggerImmediately: true).forEach((event) => _eventsController.add(event.find()));
  }

  EventDB? getEventById(int id) {
    return _eventsBox.get(id);
  }

  void addEvent(EventDB event) async {
    int id = _eventsBox.put(event);
    await _ref.child(id.toString()).set(event.toJSON());
  }

  void deleteEvent(int id) {
    _eventsBox.removeAsync(id);
  }

  void dispose() {
    _eventsController.close();
  }
}