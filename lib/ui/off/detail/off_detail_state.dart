import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_detail_state.freezed.dart';

@freezed
class OffDetailState with _$OffDetailState {
  factory OffDetailState({
    required int currentIndex,
  }) = _OffDetailState;
}