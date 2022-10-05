import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/model/content.dart';

part 'off_monthly_state.freezed.dart';

@freezed
class OffMonthlyState with _$OffMonthlyState {
  factory OffMonthlyState({
    OffIconEntity? icon,
    Content? content,
  }) = _OffMonthlyState;
}