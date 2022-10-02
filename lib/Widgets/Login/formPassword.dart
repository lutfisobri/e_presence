import 'package:flutter/material.dart';

class formPassword extends StatefulWidget {
  formPassword({
    Key? key, required this.password,
  }) : super(key: key);

  final TextEditingController password;

  @override
  State<formPassword> createState() => _showPasswordState(password: password);
}

class _showPasswordState extends State<formPassword> {
  _showPasswordState({required this.password});
  final TextEditingController password;
  bool show = false;

  Icon icon = Icon(Icons.remove_red_eye_outlined);

  showHide() {
    setState(() {
      show = !show;
      (show)
          ? icon = Icon(Icons.visibility_outlined)
          : icon = Icon(Icons.visibility_off_outlined);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: password,
      obscureText: show,
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: const Icon(Icons.key_outlined),
        suffixIcon: GestureDetector(
          onTap: () {
            showHide();
          },
          child: icon,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
    );
  }
}
