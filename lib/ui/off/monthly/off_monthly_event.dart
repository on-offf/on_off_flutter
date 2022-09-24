import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_monthly_event.freezed.dart';

@freezed
abstract class OffMonthlyEvent with _$OffMonthlyEvent {
  const factory OffMonthlyEvent.offFocusMonthSelected() = OffFocusMonthSelected;
  const factory OffMonthlyEvent.showOverlay(BuildContext context, OverlayEntry overlayEntry) = ShowOverlay;
  const factory OffMonthlyEvent.removeOverlay() = RemoveOverlay;
  const factory OffMonthlyEvent.addSelectedIconPaths(String path) = AddSelectedIconPaths;
}