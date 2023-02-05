import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';


part 'on_monthly_state.freezed.dart';

@freezed
class OnMonthlyState with _$OnMonthlyState {
  factory OnMonthlyState({
    bool? isFinished,
    List<OnTodo>? todos,
  }) = _OnMonthlyState;
}
