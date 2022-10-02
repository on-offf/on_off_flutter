import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_weekly_event.freezed.dart';

@freezed
abstract class OffWeeklyEvent with _$OffWeeklyEvent {
  const factory OffWeeklyEvent.changeContents(DateTime selectedDate) = ChangeContents;
  const factory OffWeeklyEvent.addSelectedIconPaths(DateTime selected, String path) = AddSelectedIconPaths;

  const factory OffWeeklyEvent.changeDiaryOrderType() = ChangeDiaryOrderType;
}