import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:on_off/domain/model/content.dart';

part 'off_detail_state.freezed.dart';

@freezed
class OffDetailState with _$OffDetailState {
  factory OffDetailState({
    required CarouselController carouselController,
    required int currentIndex,
    required List<String> iconPaths,
    Content? content,
  }) = _OffDetailState;
}