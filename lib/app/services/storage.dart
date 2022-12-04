import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<Map<String, dynamic>> isLogin() async {
    final sPref = await SharedPreferences.getInstance();
    final username = sPref.getString('username');
    final password = sPref.getString('password');
    return {
      'username': username,
      'password': password,
    };
  }

  static Future<bool> saveLogin({
    required String username,
    required String password,
  }) async {
    final sPref = await SharedPreferences.getInstance();
    return await sPref.setString('username', username) &&
        await sPref.setString('password', password);
  }

  static Future<bool> clearLogin() async {
    final sPref = await SharedPreferences.getInstance();
    return await sPref.remove('username') && await sPref.remove('password');
  }
}
