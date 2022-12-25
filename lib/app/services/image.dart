import 'dart:io';
import 'package:app_presensi/utils/cache_manager.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();
XFile? _photo;

Future<File?> takePhoto() async {
  // Cache().getCache();
  try {
    _photo = await _picker.pickImage(source: ImageSource.camera);
    if (_photo != null) {
      return File(_photo!.path);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<File?> pickImage() async {
  // Cache().getCache();
  try {
    _photo = await _picker.pickImage(source: ImageSource.gallery);
    if (_photo != null) {
      return File(_photo!.path);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
