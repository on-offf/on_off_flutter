import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_home_state.freezed.dart';

@freezed
class OffHomeState with _$OffHomeState {
  factory OffHomeState({
    required DateTime selectedDay,
    required DateTime focusedDay,
  }) = _OffHomeState;
}