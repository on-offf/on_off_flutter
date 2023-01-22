import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_icon_entity.freezed.dart';
part 'on_icon_entity.g.dart';

@freezed
class OnIconEntity with _$OnIconEntity {
  factory OnIconEntity({
    required int dateTime,
    required String name,
  }) = _OnIconEntity;

  factory OnIconEntity.fromJson(Map<String, dynamic> json) => _$OnIconEntityFromJson(json);
}