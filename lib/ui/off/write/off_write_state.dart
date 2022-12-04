import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/model/off_write_image.dart';

part 'off_write_state.freezed.dart';

@freezed
class OffWriteState with _$OffWriteState {
  factory OffWriteState({
    OffIconEntity? icon,
    @Default([]) List<OffWriteImage> imagePaths,
    OffDiary? offDiary,
  }) = _OffWriteState;
}
