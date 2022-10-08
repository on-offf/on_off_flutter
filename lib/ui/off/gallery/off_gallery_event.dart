import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_gallery_event.freezed.dart';

@freezed
class OffGalleryEvent with _$OffGalleryEvent {
  const factory OffGalleryEvent.init() = Init;
  const factory OffGalleryEvent.changeIndex(int index) = ChangeIndex;
}