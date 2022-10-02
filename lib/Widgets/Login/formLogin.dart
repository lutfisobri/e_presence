import 'package:flutter/material.dart';

class formUsername extends StatelessWidget {
  formUsername({
    Key? key, required this.username,
  }) : super(key: key);

  final TextEditingController username;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: username,
      decoration: InputDecoration(
        hintText: "Username",
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
    );
  }
}