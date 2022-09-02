import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_diary.freezed.dart';
part 'off_diary.g.dart';

@freezed
class OffDiary with _$OffDiary{
  factory OffDiary({
    required int dateTime,
    required String content,
    int? id,
  }) = _OffDiary;

  factory OffDiary.fromJson(Map<String, dynamic> json) => _$OffDiaryFromJson(json);
}