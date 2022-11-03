import 'dart:async';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final styleThemeData = StyleThemeData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, maxHeight) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.54, right: 25),
              height: 113,
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 3),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/viewPhoto");
                              },
                              child: Consumer<UserControlProvider>(
                                  builder: (context, value, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: value.dataUser.foto == ""
                                      ? const Image(
                                          image: AssetImage(
                                              "assets/image/profil_default.png"),
                                          width: 61,
                                          height: 61,
                                          fit: BoxFit.cover,
                                        )
                                      : Image(
                                          image: NetworkImage(
                                            value.dataUser.foto,
                                          ),
                                          width: 61,
                                          height: 61,
                                          fit: BoxFit.cover,
                                        ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 22.96,
                        ),
                        Consumer<UserControlProvider>(
                            builder: (context, usrProv, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                usrProv.dataUser.nama,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              Text(
                                "NIS ${usrProv.dataUser.nis}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              Text(
                                usrProv.dataUser.email,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                    Positioned(
                      right: 1.5,
                      top: 25,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/editProfile");
                        },
                        child: Image.asset(
                          "assets/icons/edit_profile.png",
                          height: 30,
                          width: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(
                  top: 19,
                  left: 19,
                  right: 19,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pengaturan Akun",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/ubh_sandi.png",
                        height: 30,
                        width: 30,
                      ),
                      title: const Text(
                        "Ubah Kata Sandi",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: "Roboto",
                        ),
                      ),
                      onTap: () =>
                          Navigator.pushNamed(context, "/ubahPassword"),
                    ),
                    const Divider(),
                    Consumer<UserControlProvider>(
                        builder: (context, value, child) {
                      return ListTile(
                        leading: Image.asset(
                          "assets/icons/keluar.png",
                          height: 30,
                          width: 30,
                        ),
                        title: const Text(
                          "Keluar",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "Roboto",
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/login");
                          Timer(
                            const Duration(seconds: 2),
                            () {
                              value.userClearData();
                            },
                          );
                        },
                      );
                    }),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
