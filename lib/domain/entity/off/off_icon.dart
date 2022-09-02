import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_icon.freezed.dart';
part 'off_icon.g.dart';

@freezed
class OffIcon with _$OffIcon{
  factory OffIcon({
    required int dateTime,
    required String name,
    int? id,
  }) = _OffIcon;

  factory OffIcon.fromJson(Map<String, dynamic> json) => _$OffIconFromJson(json);
}