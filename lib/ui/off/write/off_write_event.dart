import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_write_event.freezed.dart';

@freezed
abstract class OffWriteEvent with _$OffWriteEvent {
  const factory OffWriteEvent.addIcon(String path) = AddIcon;
  const factory OffWriteEvent.addSelectedImagePaths(File path) =
      AddSelectedImagePaths;
  const factory OffWriteEvent.saveContent(String text) = SaveContent;
  const factory OffWriteEvent.resetState() = ResetState;
}
