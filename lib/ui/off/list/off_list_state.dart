import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/model/content.dart';

part 'off_list_state.freezed.dart';

@freezed
class OffListState with _$OffListState {
  factory OffListState({
    required List<Content> contents,
    Map<DateTime, List<String>>? iconPathMap,
  }) = _OffListState;
}