import 'dart:math';

bool emailValidation(String email) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!emailValid) return false;
  return true;
}

bool passwordIsSame(String password, String newPassword, String confNewPw) {
  if (password == newPassword) return false;
  if (newPassword != confNewPw) return false;
  if (newPassword.length < 8 || confNewPw.length < 8) return false;
  if (password == newPassword || password == confNewPw) return false;
  return true;
}

int generateOTP() {
  var random = Random().nextInt(8999) + 1000;
  return random;
}
