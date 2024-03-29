import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

//mode = 0 : 카메라, 1 : 갤러리
Future<File?> inputImage(int mode, {double maxHeight = 600}) async {
  final picker = ImagePicker();
  final imageFile = await picker.pickImage(
    source: mode == 0 ? ImageSource.camera : ImageSource.gallery,
    maxHeight: maxHeight,
  );
  if (imageFile == null) {
    return null;
  }

  final appDir = await syspaths.getApplicationDocumentsDirectory();
  final fileName = path.basename(imageFile.path);
  final savedImage = File(imageFile.path).copy('${appDir.path}/$fileName');
  return await savedImage;
}
