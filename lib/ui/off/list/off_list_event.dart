import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_list_event.freezed.dart';

@freezed
abstract class OffListEvent with _$OffListEvent {
  const factory OffListEvent.changeContents(DateTime selectedDate) = ChangeContents;
  const factory OffListEvent.changeDiaryOrderType() = ChangeDiaryOrderType;
}