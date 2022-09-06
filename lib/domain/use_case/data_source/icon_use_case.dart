import 'package:on_off/data/data_source/db/icon_dao.dart';
import 'package:on_off/domain/entity/off_icon.dart';
import 'package:on_off/util/date_util.dart';

class IconUseCase {
  final IconDAO iconDAO;
  IconUseCase(this.iconDAO);

  Future<void> insert(OffIcon offIcon) async {
    await iconDAO.insertOffIcon(offIcon);
  }

  Future<void> delete(OffIcon offIcon) async {
    await iconDAO.deleteOffIcon(offIcon);
  }

  Future<void> update(OffIcon offIcon) async {
    await iconDAO.updateOffIcon(offIcon);
  }

  Future<OffIcon?> selectOffIcon(int id) async {
    return await iconDAO.selectOffIcon(id);
  }

  Future<List<OffIcon>> selectListByDateTime(DateTime dateTime) async {
    DateTime startDate = DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
    DateTime endDate = startDate.add(const Duration(days: 1));

    int unixStartDate = dateTimeToUnixTime(startDate);
    int unixEndDate = dateTimeToUnixTime(endDate);

    return await iconDAO.selectOffIconList(unixStartDate, unixEndDate);
  }

  Future<List<OffIcon>> selectOffIconList(DateTime startDateTime, DateTime endDateTime) async {
    startDateTime = DateTime(startDateTime.year, startDateTime.month, startDateTime.day);
    endDateTime = endDateTime.add(const Duration(days: 1));
    endDateTime = DateTime(endDateTime.year, endDateTime.month, endDateTime.day);

    int startUnixTime = dateTimeToUnixTime(startDateTime);
    int endUnixTime = dateTimeToUnixTime(endDateTime);

    return await iconDAO.selectOffIconList(startUnixTime, endUnixTime);
  }

}