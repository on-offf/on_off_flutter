import 'package:flutter/material.dart';
import 'package:on_off/ui/provider/ui_state.dart';

abstract class UiProviderObserve with ChangeNotifier {
  UiState? uiState;

  init(UiState uiState);
  update(UiState uiState);

}