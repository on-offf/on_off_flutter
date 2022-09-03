import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_write_state.freezed.dart';

@freezed
class OffWriteState with _$OffWriteState {
  factory OffWriteState({
    required List<String> seletcedIconPaths,
  }) = _OffWriteState;
}