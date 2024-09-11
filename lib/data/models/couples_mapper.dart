import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:schedule_for_ictis_flutter/domain/models/schedule_subject/schedule_subject.dart';
import 'package:schedule_for_ictis_flutter/domain/models/week_number/week_number.dart';
import 'package:schedule_for_ictis_flutter/presentation/extensions/date_time_ext.dart';

import 'couple_db.dart';

class CouplesMapper {
  static List<CoupleDB> fromJSON(Map<String, dynamic> json, {
    required WeekNumber? weekNumber,
    required ScheduleSubject scheduleSubject
  }) {
    json = json['table'];
    int studyWeekNum = json["week"];
    weekNumber = _createWeekNumberIfNull(weekNumber, studyWeekNum);

    final List<dynamic> weekSchedule = json["table"];

    List<CoupleDB> couplesDB = [];

    final times = _parseTimes(weekSchedule[1]);

    weekSchedule.skip(2).forEachIndexed((weekday, daySchedule) {
      (daySchedule as List<dynamic>).skip(1).forEachIndexed((coupleNum, coupleStr) {
        String id = _createID(
          studyWeekNum: studyWeekNum,
          scheduleSubjectID: scheduleSubject.id,
          coupleNum: coupleNum + 1,
          weekday: weekday + 1
        );

        final coupleDB = CoupleDB.fromString(coupleStr,
          coupleNum: coupleNum + 1,
          id: id,
          scheduleSubject: scheduleSubject,
          weekday: weekday + 1,
          weekNumber: weekNumber!,
          times: times[coupleNum]
        );

        couplesDB.add(coupleDB);
      });
    });

    return couplesDB;
  }

  static WeekNumber _createWeekNumberIfNull(WeekNumber? weekNumber, int studyWeekNum) {
    if (weekNumber == null) {
      final date = DateTime.now();
      weekNumber = WeekNumber(
        calendarWeekNumber: date.weekNumber,
        weekStartDate: date.subtract(Duration(days: date.weekday - 1)),
        studyWeekNumber: studyWeekNum,
      );
    }

    return weekNumber;
  }

  static String _createID({
    required int studyWeekNum,
    required String scheduleSubjectID,
    required int coupleNum,
    required int weekday
  }) {
    scheduleSubjectID = scheduleSubjectID
        .replaceAll(".html", "")
        .replaceFirst("m", "");

    return "$scheduleSubjectID-$studyWeekNum-$weekday-$coupleNum";
  }

  static List<Times> _parseTimes(List<dynamic> timesStr) {
    return timesStr.skip(1).map((timeRange) {
      final times = timeRange.split('-');
      final startTime = times[0].split(':');
      final endTime = times[1].split(':');

      return Times(
        timeStart: TimeOfDay(hour: int.parse(startTime[0]), minute: int.parse(startTime[1])),
        timeEnd: TimeOfDay(hour: int.parse(endTime[0]), minute: int.parse(endTime[1])),
      );
    }).toList();
  }
}

class Times {
  final TimeOfDay timeStart;
  final TimeOfDay timeEnd;

  const Times({required this.timeStart, required this.timeEnd});
}