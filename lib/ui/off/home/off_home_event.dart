import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_home_event.freezed.dart';

@freezed
abstract class OffHomeEvent with _$OffHomeEvent {
  const factory OffHomeEvent.offFocusMonthSelected() = OffFocusMonthSelected;
  const factory OffHomeEvent.showOverlay(BuildContext context, OverlayEntry overlayEntry) = ShowOverlay;
  const factory OffHomeEvent.removeOverlay() = RemoveOverlay;
}