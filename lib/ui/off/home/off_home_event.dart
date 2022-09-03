import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_home_event.freezed.dart';

@freezed
abstract class OffHomeEvent with _$OffHomeEvent {
  const factory OffHomeEvent.changeSelectedDay(DateTime selectedDay) = ChangeSelectedDay;
  const factory OffHomeEvent.changeFocusedDay(DateTime focusedDay) = ChangeFocusedDay;
}