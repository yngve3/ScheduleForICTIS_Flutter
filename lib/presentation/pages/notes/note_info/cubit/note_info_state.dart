import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/couple_db.dart';
import '../../../../../domain/models/note_file/note_file.dart';
import '../../../../../domain/models/reminder/reminder.dart';

part 'note_info_state.freezed.dart';

@freezed
class NoteInfoState with _$NoteInfoState {
  const factory NoteInfoState({
    CoupleDB? coupleDB,
    @Default(0) int noteID,
    @Default("") String title,
    String? description,
    @Default([]) List<NoteFile> files,
    @Default([]) List<Reminder> reminders
  }) = _NoteInfoState;
}
