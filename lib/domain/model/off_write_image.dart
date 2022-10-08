import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_write_image.freezed.dart';

@freezed
class OffWriteImage with _$OffWriteImage {
  factory OffWriteImage({
    int? id,
    required File file,
    int? diaryId,
  }) = _OffWriteImage;

}