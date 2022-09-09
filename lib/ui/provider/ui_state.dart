import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/constants/color_constants.dart';

part 'ui_state.freezed.dart';

@freezed
class UiState with _$UiState {
  factory UiState({
    required ColorConst colorConst,
    required DateTime selectedDay,
    required DateTime focusedDay,
    required DateTime changeCalendarPage,
  }) = _UiState;
}