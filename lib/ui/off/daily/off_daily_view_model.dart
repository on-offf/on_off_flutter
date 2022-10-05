import 'package:carousel_slider/carousel_slider.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/ui/off/daily/off_daily_event.dart';
import 'package:on_off/ui/off/daily/off_daily_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';

class OffDailyViewModel extends UiProviderObserve {
  OffDailyState _state = OffDailyState(
    currentIndex: 0,
    carouselController: CarouselController(),
  );

  final OffIconUseCase offIconUseCase;

  OffDailyViewModel({
    required this.offIconUseCase,
  });

  OffDailyState get state => _state;

  void onEvent(OffDailyEvent event) {
    event.when(
      changeCurrentIndex: _changeCurrentIndex,
      getIcon: _getIcon,
      addIcon: _addIcon,
    );
  }

  void _addIcon(DateTime selectedDate, String path) async {
    selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9);
    var offIcon = await offIconUseCase.insert(selectedDate, path);

    _state = _state.copyWith(icon: offIcon);
    notifyListeners();
  }

  void _getIcon(OffIconEntity? offIcon) async {
    _state = _state.copyWith(icon: offIcon);
    notifyListeners();
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