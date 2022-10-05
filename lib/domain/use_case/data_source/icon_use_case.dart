import 'package:on_off/data/data_source/db/off/off_icon_dao.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/util/date_util.dart';

class OffIconUseCase {
  final OffIconDAO offIconDAO;

  OffIconUseCase(this.offIconDAO);

  Future<OffIconEntity> insert(DateTime dateTime, String name) async {
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
    int unixTime = dateTimeToUnixTime(dateTime);
    await offIconDAO.deleteOffIcon(unixTime);
    return await _insertEntity(
      OffIconEntity(
        dateTime: unixTime,
        name: name,
      ),
    );
  }

  Future<OffIconEntity> _insertEntity(OffIconEntity iconEntity) async {
    await offIconDAO.insertOffIcon(iconEntity);
    return iconEntity;
  }

  Future<void> delete(DateTime dateTime) async {
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
    int unixTime = dateTimeToUnixTime(dateTime);
    await offIconDAO.deleteOffIcon(unixTime);
  }

  Future<void> update(DateTime dateTime, String name) async {
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
    int unixTime = dateTimeToUnixTime(dateTime);

    var offIcon = OffIconEntity(
      dateTime: unixTime,
      name: name
    );

    await offIconDAO.updateOffIcon(offIcon);
  }

  Future<OffIconEntity?> selectOffIcon(DateTime dateTime) async {
    int unixTime = dateTimeToUnixTime(DateTime(dateTime.year, dateTime.month, dateTime.day));
    return await offIconDAO.selectOffIcon(unixTime);
  }

  Future<List<OffIconEntity>> selectOffIconList(
      DateTime startDateTime, DateTime endDateTime) async {
    startDateTime =
        DateTime(startDateTime.year, startDateTime.month, startDateTime.day);
    endDateTime = endDateTime.add(const Duration(days: 1));
    endDateTime =
        DateTime(endDateTime.year, endDateTime.month, endDateTime.day);

    int startUnixTime = dateTimeToUnixTime(startDateTime);
    int endUnixTime = dateTimeToUnixTime(endDateTime);

    return await offIconDAO.selectOffIconList(startUnixTime, endUnixTime);
  }
}
