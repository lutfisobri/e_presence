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
  if (password == newPassword || password == confNewPw) return false;
  return true;
}
