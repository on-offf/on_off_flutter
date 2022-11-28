import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
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

  OffMonthlyState _state = OffMonthlyState();

  OffMonthlyState get state => _state;

  initScreen() async {
    changeFocusedDay(uiState!.focusedDay);
  }

  changeFocusedDay(DateTime focusedDay) async {
    _changeFocusedDay(focusedDay);
    notifyListeners();
  }

  _changeFocusedDay(DateTime focusedDay) async {
    OffDiary? offDiary = await offDiaryUseCase.selectByDateTime(focusedDay);

    if (offDiary != null) {
      List<OffImage> imageList =
      await offImageUseCase.selectOffImageList(offDiary.id!);

      Content content = Content(
        id: offDiary.id,
        time: unixToDateTime(offDiary.dateTime),
        title: offDiary.title,
        imageList: imageList,
        content: offDiary.content,
      );

      _state = _state.copyWith(content: content);
    } else {
      _state = _state.copyWith(content: null);
    }

    OffIconEntity? icon = await offIconUseCase.selectOffIcon(focusedDay);
    _state = _state.copyWith(icon: icon);
  }

  @override
  init(UiState uiState) async {
    this.uiState = uiState.copyWith();

    _changeFocusedDay(uiState.focusedDay);
  }

  @override
  update(UiState uiState) async {
    if (this.uiState!.focusedDay != uiState.focusedDay) {
      await changeFocusedDay(uiState.focusedDay);
    }

    this.uiState = uiState.copyWith();
  }
}
