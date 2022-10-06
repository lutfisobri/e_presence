import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  ButtonLogin({
    Key? key,
    required this.onPres,
  }) : super(key: key);

  final VoidCallback onPres;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPres,
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 104, 187, 97),
              ),
              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              minimumSize: const MaterialStatePropertyAll<Size>(
                Size(
                  double.infinity,
                  45,
                ),
              ),
              textStyle: const MaterialStatePropertyAll<TextStyle>(
                TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            child: Text("Login"),
          ),
        ),
      ],
    );
  }
}