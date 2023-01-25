import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/on/on_todo.dart';
import '../../../domain/model/content.dart';

part 'on_monthly_state.freezed.dart';

@freezed
class OnMonthlyState with _$OnMonthlyState {
  factory OnMonthlyState({
    // required bool test,
    bool? isFinished,
    List<OnTodo>? todos,
  }) = _OnMonthlyState;
}
