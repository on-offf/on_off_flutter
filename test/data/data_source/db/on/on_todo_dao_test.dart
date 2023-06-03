import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/on/on_todo_dao.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';
import 'package:on_off/util/date_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(OnTodoDAO.ddl);

  final onTodoDAO = OnTodoDAO(database);

  DateTime now = DateTime.now();
  var unixTime = dateTimeToUnixTime(now);

  DateTime todayStartDate = DateTime(now.year, now.month, now.day);
  DateTime todayEndDate = todayStartDate.add(const Duration(days: 1));

  int todayUnixStartDate = dateTimeToUnixTime(todayStartDate);
  int todayUnixEndDate = dateTimeToUnixTime(todayEndDate);

  OnTodo todayFirstTodo = OnTodo(
      dateTime: unixTime,
      title: '일기 쓰기',
      status: 0,
  );

  OnTodo todaySecondTodo = OnTodo(
    dateTime: unixTime,
    title: '식사 하기',
    status: 0,
  );

  test('on_todo_dao_test', () async {
    await onTodoDAO.insertOnTodo(todayFirstTodo);
    await onTodoDAO.insertOnTodo(todaySecondTodo);
    String order = 'dateTime';

    List<OnTodo> todayTodoList = await onTodoDAO.selectOnTodoList(todayUnixStartDate, todayUnixEndDate, order);

    expect(todayTodoList, isNot(null));

    expect(todayTodoList.length, 2);

    for (var element in todayTodoList) {
      expect(element.status, 0);
    }

    OnTodo onTodo = todayTodoList.first.copyWith(status: 1);

    await onTodoDAO.updateOnTodo(onTodo);

    todayTodoList = await onTodoDAO.selectOnTodoList(todayUnixStartDate, todayUnixEndDate, order);

    expect(todayTodoList.first.status, 1);

    int statusCount = 0;

    for (var element in todayTodoList) {
      statusCount += element.status;
    }

    expect(statusCount, 1);

    await onTodoDAO.deleteOnTodo(todayTodoList.first.id!);

    todayTodoList = await onTodoDAO.selectOnTodoList(todayUnixStartDate, todayUnixEndDate, order);

    expect(todayTodoList.length, 1);
  });
}