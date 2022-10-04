import 'package:flutter/material.dart';
import '../../Widgets/textfield.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final TextEditingController pwLama = TextEditingController();
  final TextEditingController pwBaru = TextEditingController();
  final TextEditingController confpwBaru = TextEditingController();
  final Color colorGreen = const Color.fromARGB(255, 114, 182, 108);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pwLama.dispose();
        pwBaru.dispose();
        confpwBaru.dispose();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ubah Kata Sandi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Password Lama *"),
                textfield(
                  controller: pwLama,
                  obscure: true,
                  hintText: "Password Lama",
                  sufixIcon1: Icon(Icons.visibility_off),
                  sufixIcon2: Icon(Icons.visibility),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Password Baru *"),
                textfield(
                  controller: pwBaru,
                  obscure: true,
                  hintText: "Password Baru",
                  sufixIcon1: Icon(Icons.visibility_off),
                  sufixIcon2: Icon(Icons.visibility),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Konfirmasi Password Baru *"),
                textfield(
                  controller: confpwBaru,
                  obscure: true,
                  hintText: "Konfirmasi Password Baru",
                  sufixIcon1: Icon(Icons.visibility_off),
                  sufixIcon2: Icon(Icons.visibility),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              11,
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          colorGreen,
                        ),
                      ),
                      child: Text("Ubah"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
