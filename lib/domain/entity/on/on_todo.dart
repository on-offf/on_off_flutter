import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_todo.freezed.dart';
part 'on_todo.g.dart';

/// status
/// - 1: 완료
/// - 2: 미완료
@freezed
class OnTodo with _$OnTodo {
  factory OnTodo({
    required int dateTime,
    required String title,
    required int status,
    String? content,
    int? completeDateTime,
    int? id,
    int? todoOrder,
  }) = _OnTodo;

  factory OnTodo.fromJson(Map<String, dynamic> json) => _$OnTodoFromJson(json);
}
