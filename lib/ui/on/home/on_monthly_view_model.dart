import 'package:on_off/ui/on/home/on_monthly_event.dart';
import 'package:on_off/ui/on/home/on_monthly_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';

class OnMonthlyViewModel extends UiProviderObserve {
  OnMonthlyState _state = OnMonthlyState(
    test: false,
  );

  void onEvent(OnMonthlyEvent event) {
    event.when(
      test: _test,
    );
  }

  void _test() {
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