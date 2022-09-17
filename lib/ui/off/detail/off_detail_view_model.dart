import 'package:carousel_slider/carousel_slider.dart';
import 'package:on_off/domain/entity/icon_entity.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/ui/off/detail/off_detail_event.dart';
import 'package:on_off/ui/off/detail/off_detail_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/util/date_util.dart';

class OffDetailViewModel extends UiProviderObserve {
  OffDetailState _state = OffDetailState(
    currentIndex: 0,
    carouselController: CarouselController(),
    iconPaths: [],
  );

  final IconUseCase iconUseCase;

  OffDetailViewModel({
    required this.iconUseCase,
  });

  OffDetailState get state => _state;

  void onEvent(OffDetailEvent event) {
    event.when(
      changeCurrentIndex: _changeCurrentIndex,
      getIconPaths: _getIconPaths,
      addSelectedIconPaths: _addSelectedIconPaths,
    );
  }

  void _addSelectedIconPaths(DateTime selectedDate, String path) async {
    selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9);

    List<IconEntity> iconList = await iconUseCase.selectListByDateTime(selectedDate);
    bool saveIcon = true;

    for (var iconEntity in iconList) {
      if (iconEntity.name == path) saveIcon = false;
    }

    if (saveIcon) {
      IconEntity entity = IconEntity(
        dateTime: dateTimeToUnixTime(selectedDate),
        name: path,
      );

      await iconUseCase.insert(entity);
      _addIconPathInState(path);

      notifyListeners();
    }
  }

  void _addIconPathInState(String path) {
    List<String> iconPathList = [];
    iconPathList.addAll(_state.iconPaths);
    iconPathList.add(path);
    _state = _state.copyWith(iconPaths: iconPathList);
  }

  void _getIconPaths(List<String> iconPaths) async {
    if (_state.iconPaths.isNotEmpty) {
      return;
    }
    _state = _state.copyWith(iconPaths: iconPaths);
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