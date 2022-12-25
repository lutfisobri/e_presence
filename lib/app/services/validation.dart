bool emailValidation(String email) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!emailValid) return false;
  return true;
}

int passwordIsSame(String password, String newPassword, String confNewPw) {
  if (password == newPassword && confNewPw == password) return 1;
  if (newPassword != confNewPw) return 2;
  if (newPassword.length < 8 || confNewPw.length < 8) return 3;
  if (password == newPassword || password == confNewPw) return 4;
  if (password == "" || newPassword == "" || confNewPw == "") return 5;
  return 0;
}