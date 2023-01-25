import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_todo.freezed.dart';
part 'on_todo.g.dart';

@freezed
class OnTodo with _$OnTodo {
  factory OnTodo({
    required int dateTime,
    required String title,
    required String content,
    required bool status, //true = finished(checked)
    int? completeDateTime,
    int? id,
  }) = _OnTodo;

  factory OnTodo.fromJson(Map<String, dynamic> json) => _$OnTodoFromJson(json);
}
