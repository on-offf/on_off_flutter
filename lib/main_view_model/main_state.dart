import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/constants/color_constants.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  factory MainState({
    required ColorConst colorConst,
  }) = _MainState;

}