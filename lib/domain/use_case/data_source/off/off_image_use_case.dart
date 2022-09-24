import 'package:on_off/data/data_source/db/off/off_image_dao.dart';
import 'package:on_off/domain/entity/off/off_image.dart';

class OffImageUseCase {
  final OffImageDAO offImageDAO;
  OffImageUseCase(this.offImageDAO);

  Future<void> insert(OffImage offImage) async {
    await offImageDAO.insertOffImage(offImage);
  }

  Future<void> insertAll(List<OffImage> offImageList) async {
    await offImageDAO.insertOffImageList(offImageList);
  }

  Future<void> delete(int id) async {
    await offImageDAO.deleteOffImage(id);
  }

  Future<List<OffImage>> selectOffImageList(int diaryId) async {
    List<OffImage> list = await offImageDAO.selectOffImageListByOffDiaryId(diaryId);
    return list;
  }

}