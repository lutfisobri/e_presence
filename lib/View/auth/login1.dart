import 'dart:async';

import 'package:e_presence/View/route/Beranda.dart';
import 'package:flutter/material.dart';

class loginF extends StatelessWidget {
  loginF({super.key});
  Color colorGreen = Color.fromARGB(255, 114, 182, 108);
  // bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/wave/top-wave.png",
                fit: BoxFit.fill,
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/image/logo-splash1.png"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "E-PRESENSI\nSMAN PLUS SUKOWONO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: colorGreen,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  // padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 0),
                          blurRadius: 15,
                        ),
                      ]),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 27,
                              color: colorGreen,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Masukkan username dan password"),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        btnLupaPw(),
                        const SizedBox(
                          height: 5,
                        ),
                        loginBtn(colorGreen: colorGreen),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              width: MediaQuery.of(context).size.width,
              image: const AssetImage("assets/wave/bottom-wave.png"),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class btnLupaPw extends StatelessWidget {
  const btnLupaPw({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            
          },
          child: const Text("lupa password ?"),
        ),
      ],
    );
  }
}

class loginBtn extends StatefulWidget {
  const loginBtn({
    Key? key,
    required this.colorGreen,
  }) : super(key: key);

  final Color colorGreen;

  @override
  State<loginBtn> createState() => _loginBtnState();
}

class _loginBtnState extends State<loginBtn> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            ),
            backgroundColor: MaterialStatePropertyAll<Color>(widget.colorGreen),
          ),
          child: Text("Lupa"),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              Timer(
                Duration(seconds: 1),
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Beranda(),
                    ),
                  );
                  isLoading = false;
                },
              );
            },
            style: ButtonStyle(
              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
              ),
              backgroundColor:
                  MaterialStatePropertyAll<Color>(widget.colorGreen),
            ),
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("LOGIN"),
          ),
        ),
      ],
    );
  }
}
