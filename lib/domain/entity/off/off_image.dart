import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_image.freezed.dart';
part 'off_image.g.dart';

@freezed
class OffImage with _$OffImage{
  factory OffImage({
    required int offDiaryId,
    required String path,
    int? id,
  }) = _OffImage;

  factory OffImage.fromJson(Map<String, dynamic> json) => _$OffImageFromJson(json);
}