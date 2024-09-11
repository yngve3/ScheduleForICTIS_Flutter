import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/reminder/reminder.dart';

part 'event_info_state.freezed.dart';

@freezed
class EventInfoState with _$EventInfoState {
  const factory EventInfoState({
    @Default(0) int id,
    @Default("") String title,
    String? description,
    DateTime? date,
    TimeOfDay? timeStart,
    TimeOfDay? timeEnd,
    String? location,
    List<Reminder>? reminders
  }) = _EventInfoState;
}
