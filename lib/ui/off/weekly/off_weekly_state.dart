import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/model/content.dart';

part 'off_weekly_state.freezed.dart';

@freezed
class OffWeeklyState with _$OffWeeklyState {
  factory OffWeeklyState({
    required List<Content> contents,
    required Map<int, OffIconEntity> iconMap,

    required bool isAscending,
  }) = _OffWeeklyState;
}