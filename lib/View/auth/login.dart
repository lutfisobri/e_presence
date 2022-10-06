import 'package:e_presence/controller/user_controller.dart';
import 'package:flutter/material.dart';
import '../../Widgets/Login/btn_login.dart';
import '../../Widgets/Login/form_login.dart';
import '../../Widgets/Login/form_password.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 245, 245, 245),
                Color.fromARGB(255, 245, 245, 245),
                // Colors.blue,
                // Colors.amber,
                // Colors.greenAccent,
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                height: height / 3.44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage("assets/image/logo-sekolah.png"),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "E-PRESENCE\nSMA NEGERI PLUS\nSUKOWONO",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: height / 1.41,
                child: Material(
                  elevation: 8,
                  shadowColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          height: 10,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(fontSize: 26),
                        ),
                        Container(
                          height: 30,
                        ),
                        FormUsername(username: username),
                        const SizedBox(
                          height: 10,
                        ),
                        FormPassword(
                          password: password,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "LUPA PASSWORD ?",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 104, 187, 97),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonLogin(onPres: () {
                          UserControlProvider auth = UserControlProvider();
                          auth.getUser(username.text, password.text);
                        }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}