import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';

part 'on_monthly_state.freezed.dart';

@freezed
class OnMonthlyState with _$OnMonthlyState {
  factory OnMonthlyState({
    required String order,
    required bool multiDeleteStatus,
    required Map<int, bool> multiDeleteTodoIds,
    /**
     * 0: 미완료 일정만
     * 1: 완료 일정만
     * 2: 전체 일정 보기
     */
    required int showStatus,
    bool? isFinished,
    List<OnTodo>? todos,
    ScrollController? onMonthlyScreenScrollerController,
    required double keyboardHeight,

    // OnTodoComponents
    ScrollController? todoComponentsController,
    required double todoComponentsHeight,
    GlobalKey? todoComponentsKey,

    FocusNode? todoInputFocusNode,
  }) = _OnMonthlyState;
}
