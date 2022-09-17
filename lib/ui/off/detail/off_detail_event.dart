import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_detail_event.freezed.dart';

@freezed
abstract class OffDetailEvent with _$OffDetailEvent {
  const factory OffDetailEvent.changeCurrentIndex(int currentIndex) = ChangeCurrentIndex;
  const factory OffDetailEvent.getIconPaths(List<String> iconpaths) = GetIconPaths;
  const factory OffDetailEvent.addSelectedIconPaths(DateTime selectedDate, String path) = AddSelectedIconPaths;
}