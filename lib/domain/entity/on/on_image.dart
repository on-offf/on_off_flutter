import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_image.freezed.dart';
part 'on_image.g.dart';

@freezed
class OnImage with _$OnImage {
  factory OnImage({
    required int OnTodoId,
    required dynamic imageFile,
    int? id,
  }) = _OnImage;

  factory OnImage.fromJson(Map<String, dynamic> json) => _$OnImageFromJson(json);
}