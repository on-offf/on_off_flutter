import 'package:on_off/data/data_source/db/on/on_todo_dao.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';
import 'package:on_off/util/date_util.dart';

class OnTodoUseCase {
  final OnTodoDAO onTodoDAO;

  OnTodoUseCase(this.onTodoDAO);

  Future<OnTodo> insertOnTodo(DateTime dateTime, String title) async {
    int unixTime = dateTimeToUnixTime(dateTime);
    OnTodo onTodo = OnTodo(
      dateTime: unixTime,
      title: title,
      status: 0
    );
    return await onTodoDAO.insertOnTodo(onTodo);
  }

  /// 순서 변경시 사용: 하나만 변경하는 것이 아니라, 해당 일자의 모든 todo의 순서를 변경해야함
  Future<void> updateTodoList(List<OnTodo> todoList) async {
    for (var onTodo in todoList) {
      await onTodoDAO.updateOnTodo(onTodo);
    }
  }

  Future<void> updateTodoStatus(OnTodo onTodo) async {
    await onTodoDAO.updateOnTodo(onTodo);
  }

  Future<void> deleteOnTodo(OnTodo onTodo) async {
    await onTodoDAO.deleteOnTodo(onTodo.id!);
  }

  Future<void> deleteMultiOnTodo(List<OnTodo> todoList) async {
    for (var onTodo in todoList) {
      await onTodoDAO.deleteOnTodo(onTodo.id!);
    }
  }

  /// order: dateTime, todoOrder
  Future<List<OnTodo>> selectOnTodoList(DateTime dateTime, String order, int? status) async {
    if (order != 'dateTime' || order != 'todoOrder') {
      order = 'todoOrder';
    }

    DateTime startDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
    DateTime endDateTime = startDateTime.add(const Duration(days: 1));

    int startUnixTime = dateTimeToUnixTime(startDateTime);
    int endUnixTime = dateTimeToUnixTime(endDateTime);

    Future<List<OnTodo>> todoList = onTodoDAO.selectOnTodoList(startUnixTime, endUnixTime, order);
    return filterTodoStatus(todoList, status);
  }

  Future<List<OnTodo>> filterTodoStatus(Future<List<OnTodo>> todoList, int? status) async {
    if (status == null) {
      return await todoList;
    }

    List<OnTodo> copyTodoList = [];

    for (var todo in await todoList) {
      if (todo.status == status) {
        copyTodoList.add(todo);
      }
    }

    return copyTodoList;
  }



}