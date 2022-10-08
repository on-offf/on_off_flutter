import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/monthly/off_monthly_event.dart';
import 'package:on_off/ui/off/monthly/off_monthly_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/util/date_util.dart';

class OffMonthlyViewModel extends UiProviderObserve {
  final OffDiaryUseCase offDiaryUseCase;
  final OffIconUseCase offIconUseCase;
  final OffImageUseCase offImageUseCase;

  OffMonthlyViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.offIconUseCase,
  });

  OffMonthlyState _state = OffMonthlyState(
  );

  OffMonthlyState get state => _state;

  void onEvent(OffMonthlyEvent event) {
    event.when(
      init: initScreen,
    );
  }

  void initScreen() {
    _changeFocusedDay(uiState!.focusedDay);
  }

  void _changeFocusedDay(DateTime focusedDay) async {
    OffDiary? offDiary = await offDiaryUseCase.selectByDateTime(focusedDay);

    if (offDiary != null) {
      List<OffImage> imageList = await offImageUseCase.selectOffImageList(offDiary.id!);

      Content content = Content(
        time: unixToDateTime(offDiary.dateTime),
        imageList: imageList,
        content: offDiary.content,
      );

      _state = _state.copyWith(content: content);
    } else {
      _state = _state.copyWith(content: null);
    }

    OffIconEntity? icon = await offIconUseCase.selectOffIcon(focusedDay);
    _state = _state.copyWith(icon: icon);

    notifyListeners();
  }

  @override
  init(UiState uiState) {
    this.uiState = uiState;

    _changeFocusedDay(uiState.focusedDay);
  }

  @override
  update(UiState uiState) {
    if (this.uiState!.focusedDay != uiState.focusedDay) {
      _changeFocusedDay(uiState.focusedDay);
    }

    this.uiState = uiState.copyWith();
  }
}
