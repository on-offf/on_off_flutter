import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_icon_entity.freezed.dart';
part 'off_icon_entity.g.dart';

@freezed
class OffIconEntity with _$OffIconEntity{
  factory OffIconEntity({
    required int dateTime,
    required String name,
  }) = _OffIconEntity;

  factory OffIconEntity.fromJson(Map<String, dynamic> json) => _$OffIconEntityFromJson(json);
}