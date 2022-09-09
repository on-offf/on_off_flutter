import 'package:carousel_slider/carousel_slider.dart';
import 'package:on_off/ui/off/detail/off_detail_event.dart';
import 'package:on_off/ui/off/detail/off_detail_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';

class OffDetailViewModel extends UiProviderObserve {
  OffDetailState _state = OffDetailState(
    currentIndex: 0,
    carouselController: CarouselController(),
  );

  OffDetailState get state => _state;

  void onEvent(OffDetailEvent event) {
    event.when(
        changeCurrentIndex: _changeCurrentIndex,
    );
  }

  void _changeCurrentIndex(int currentIndex) {
    _state = _state.copyWith(currentIndex: currentIndex);
    notifyListeners();
  }

  @override
  init(UiState uiState) {
    this.uiState = uiState;
  }

  @override
  update(UiState uiState) {
    this.uiState = uiState;
  }


}