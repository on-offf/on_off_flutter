import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/off/off_image.dart';

part 'off_gallery_event.freezed.dart';

@freezed
class OffGalleryEvent with _$OffGalleryEvent {
  const factory OffGalleryEvent.init(List<OffImage> offImageList) = Init;
  const factory OffGalleryEvent.changeIndex(int index) = ChangeIndex;
}