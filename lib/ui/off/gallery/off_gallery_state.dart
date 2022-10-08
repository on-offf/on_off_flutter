import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/off/off_image.dart';

part 'off_gallery_state.freezed.dart';

@freezed
class OffGalleryState with _$OffGalleryState {
  factory OffGalleryState({
    required List<OffImage> offImageList,
    required int index,
  }) = _OffGalleryState;
}