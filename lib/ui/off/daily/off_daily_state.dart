import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/model/content.dart';

part 'off_daily_state.freezed.dart';

@freezed
class OffDailyState with _$OffDailyState {
  factory OffDailyState({
    required CarouselController carouselController,
    required int currentIndex,
    OffIconEntity? icon,
    Content? content,
  }) = _OffDailyState;
}