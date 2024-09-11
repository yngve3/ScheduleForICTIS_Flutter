import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/note/note.dart';
import '../../../../domain/models/schedule/day_schedule_item.dart';
import '../../../../domain/models/week_number/week_number.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default([]) List<DayScheduleItem> scheduleItems,
    @Default([]) List<Note> notes,
    WeekNumber? weekNumber
  }) = _HomePageState;
}
