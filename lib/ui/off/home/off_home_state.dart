import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/model/content.dart';

part 'off_home_state.freezed.dart';

@freezed
class OffHomeState with _$OffHomeState {
  factory OffHomeState({
    required DateTime selectedDay,
    required DateTime focusedDay,
    required DateTime changeCalendarPage,
    Content? content,
  }) = _OffHomeState;
}