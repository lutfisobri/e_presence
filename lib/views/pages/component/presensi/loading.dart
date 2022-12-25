import 'package:flutter/material.dart';

class PresensiLoading extends StatelessWidget {
  const PresensiLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white.withOpacity(0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/loading/pensil.gif",
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 2.63,
          ),
          const Text(
            "Tunggu Proses",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w700,
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );
  }
}