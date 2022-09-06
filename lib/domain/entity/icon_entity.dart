import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_entity.freezed.dart';
part 'icon_entity.g.dart';

@freezed
class IconEntity with _$IconEntity{
  factory IconEntity({
    required int dateTime,
    required String name,
    int? id,
  }) = _IconEntity;

  factory IconEntity.fromJson(Map<String, dynamic> json) => _$IconEntityFromJson(json);
}