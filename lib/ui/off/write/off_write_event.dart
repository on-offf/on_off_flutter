import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_write_event.freezed.dart';

@freezed
abstract class OffWriteEvent with _$OffWriteEvent {
  const factory OffWriteEvent.addSelectedIconPaths(String path) = AddSelectedIconPaths;
}