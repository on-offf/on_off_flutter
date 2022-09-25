import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_monthly_state.freezed.dart';

@freezed
class OnMonthlyState with _$OnMonthlyState {
  factory OnMonthlyState({
    required bool test,
  }) = _OnMonthlyState;

}