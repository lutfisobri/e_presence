import 'package:e_presence/controller/API_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class edit_Profile extends StatelessWidget {
  const edit_Profile({super.key});

  final Color colorGreen = const Color.fromARGB(255, 114, 182, 108);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Consumer<API_controller>(
                        builder: (context, value, child) => ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: NetworkImage(value.getUser[0].photoUrl),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Nama Lengkap *"),
                    TextFormField(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("E-mail *"),
                    TextFormField(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Nisn"),
                    TextFormField(
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Tanggal Lahir *"),
                    TextFormField(
                      onTap: () {},
                      readOnly: true,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Kelas"),
                    TextFormField(
                      enabled: false,
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
                              shape: MaterialStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)),
                              ),
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  colorGreen),
                            ),
                            child: const Text("Simpan"))
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: 265,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
