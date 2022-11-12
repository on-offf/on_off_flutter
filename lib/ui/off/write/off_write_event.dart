import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/model/off_write_image.dart';

part 'off_write_event.freezed.dart';

@freezed
abstract class OffWriteEvent with _$OffWriteEvent {
  const factory OffWriteEvent.addIcon(String path) = AddIcon;
  const factory OffWriteEvent.addSelectedImagePaths(File path) =
      AddSelectedImagePaths;
  const factory OffWriteEvent.saveContent(String title, String content) = SaveContent;
  const factory OffWriteEvent.resetState() = ResetState;
  const factory OffWriteEvent.getFocusedDayDetail() = GetFocusedDayDetail;
  const factory OffWriteEvent.removeImage(OffWriteImage offWriteImage) = RemoveEvent;
  const factory OffWriteEvent.removeContent() = RemoveContent;
}
