import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/model/content.dart';

part 'off_monthly_state.freezed.dart';

@freezed
class OffMonthlyState with _$OffMonthlyState {
  factory OffMonthlyState({
    required bool offFocusMonthSelected,
    @Default([]) List<String> iconPaths,
    OverlayEntry? overlayEntry,
    Content? content,
  }) = _OffMonthlyState;
}