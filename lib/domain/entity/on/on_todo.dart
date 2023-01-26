import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_todo.freezed.dart';
part 'on_todo.g.dart';

@freezed
class OnTodo with _$OnTodo {
  factory OnTodo({
    required int dateTime,
    required String title,
    required bool status, //true = finished(checked)
    String? content,
    int? completeDateTime,
    int? id,
    int? todoOrder,
  }) = _OnTodo;

  factory OnTodo.fromJson(Map<String, dynamic> json) => _$OnTodoFromJson(json);
}
