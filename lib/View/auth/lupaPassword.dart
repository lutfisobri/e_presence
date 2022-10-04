import 'package:flutter/material.dart';

class LupaPassword extends StatelessWidget {
  const LupaPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lupa Password"),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
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
              ElevatedButton(
                onPressed: () {},
                child: Text("Lanjutkan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
