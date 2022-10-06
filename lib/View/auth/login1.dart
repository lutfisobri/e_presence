import 'dart:async';
import 'package:e_presence/View/auth/lupa_password.dart';
import 'package:e_presence/View/route/beranda.dart';
import 'package:flutter/material.dart';

class LoginF extends StatelessWidget {
  LoginF({super.key});
  Color colorGreen = const Color.fromARGB(255, 114, 182, 108);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
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
                    // width: 100,
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
                    margin: const EdgeInsets.only(left: 20, right: 20),
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
                              prefixIcon: Icon(Icons.account_box),
                              hintText: "Username",
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.key),
                              hintText: "Password",
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11)),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // btnLupaPw(),
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LupaPassword(),));

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ChangePassword(),),
            // );
          },
          style: ButtonStyle(
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            ),
            backgroundColor: MaterialStatePropertyAll<Color>(widget.colorGreen),
          ),
          child: Icon(Icons.key),
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
                ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text("LOGIN"),
          ),
        ),
      ],
    );
  }
}
