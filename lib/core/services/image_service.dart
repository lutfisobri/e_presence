import 'dart:io';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();
  XFile? _photo;

  Future<File?> takePhoto() async {
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