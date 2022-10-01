import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_monthly_event.freezed.dart';

@freezed
abstract class OffMonthlyEvent with _$OffMonthlyEvent {
  const factory OffMonthlyEvent.addSelectedIconPaths(String path) = AddSelectedIconPaths;
}