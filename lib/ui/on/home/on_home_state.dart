import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_home_state.freezed.dart';

@freezed
class OnHomeState with _$OnHomeState {
  factory OnHomeState({
    required bool test,
  }) = _OnHomeState;

}