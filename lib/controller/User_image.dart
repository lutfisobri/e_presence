import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class userImage with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  // XFile? image;
  XFile? photo;

  File? source;

  pickImage() async {
    // image = await _picker.pickImage(source: ImageSource.gallery);
    try {
      photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        source = File(photo!.path);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  reset() {
    photo == null;
    source == null;
    print(photo!.path);
    notifyListeners();
  }

  get path => source;
}
