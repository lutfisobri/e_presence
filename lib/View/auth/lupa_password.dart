import 'package:flutter/material.dart';

class LupaPassword extends StatelessWidget {
  const LupaPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lupa Password"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Masukkan E-Mail*"),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "email",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Lanjutkan"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
