import 'package:app_presensi/app/api/user.dart';
import 'package:app_presensi/app/models/user.dart';
import 'package:app_presensi/app/services/storage.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  bool isLogin = false;
  ModelUser dataUser = ModelUser(
    username: '',
    nama: '',
    kelas: '',
    idKelas: '',
    tglLahir: '',
  );
  Map<String, dynamic> dataOTP = {};

  Future<bool> login({
    required String username,
    required String password,
    required String deviceId,
  }) async {
    var user = await User.login({
      "username": username,
      "password": password,
      "deviceId": deviceId,
    }).then((value) {
      Storage.saveLogin(
        username: username,
        password: password,
      );
      dataUser = ModelUser.formJson(value);
      isLogin = true;
      notifyListeners();
      return true;
    }).catchError((e) {
      return false;
    });
    return user;
  }

  Future<bool> checkAccount() async {
    final dataLogin = await Storage.isLogin();
    if (dataLogin['username'] != null) {
      final user = await User.checkIsLogin({
        "username": dataLogin['username'],
        "password": dataLogin['password'],
        "deviceId": dataUser.deviceId,
      }).then((value) {
        return value;
      }).catchError((e) {
        return false;
      });
      return user;
    } else {
      return false;
    }
  }

  Future<bool> autoLogin(String deviceId) async {
    final dataLogin = await Storage.isLogin();
    if (dataLogin['username'] != null) {
      final user = await User.autoLogin({
        "username": dataLogin['username'],
        "password": dataLogin['password'],
        "deviceId": deviceId,
      }).then((value) {
        dataUser = ModelUser.formJson(value);
        isLogin = true;
        notifyListeners();
        return true;
      }).catchError((e) {
        return false;
      });
      return user;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    final dataLogin = await Storage.isLogin();
    if (dataLogin['username'] != null) {
      final user = await User.logout(dataUser.username).then((value) {
        Storage.clearLogin();
        dataUser.clear();
        isLogin = false;
        notifyListeners();
        return true;
      }).catchError((e) {
        return false;
      });
      return user;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(
      String email, String? photo, String tglLahir) async {
    final user = await User.update({
      "username": dataUser.username,
      "email": email,
      "foto": photo,
      "tanggal_lahir": tglLahir,
    }).then((value) {
      dataUser = ModelUser.formJson(value);
      isLogin = true;
      notifyListeners();
      return true;
    }).catchError((e) {
      print(e);
      return false;
    });
    return user;
  }

  Future<bool> deletePhoto(String username) async {
    final user = await User.deleteFoto(username: username).then((value) {
      dataUser = ModelUser.formJson(value);
      isLogin = true;
      notifyListeners();
      return true;
    }).catchError((e) {
      return false;
    });
    return user;
  }

  Future<bool> changePassword({
    required String password,
    required String newPassword,
  }) async {
    final user = await User.updatePw({
      "username": dataUser.username,
      "password": password,
      "new_password": newPassword,
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
    return user;
  }

  Future<bool> forgotChangePassword({
    required String username,
    required String password,
  }) async {
    final user = User.changePw({
      "username": username,
      "password": password,
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
    return user;
  }

  Future<Map<String, dynamic>> searchAccount(String username) async {
    final user = await User.search(username: username).then((value) {
      return value;
    }).catchError((e) {
      return {
        "nis": "",
      };
    });
    return user;
  }

  Future<bool> sendMail(String username, String email) async {
    final user = await User.mail({
      "username": username,
      "email": email,
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
    return user;
  }

  Future<int> verificationOTP(String otp, String username) async {
    var json = {
      "otp": otp,
      "username": username,
    };
    final user = await User.verifyotp(json).then((value) {
      return value;
    }).catchError((e) {
      return 0;
    });
    return user;
  }
}
