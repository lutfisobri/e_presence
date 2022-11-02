import 'dart:async';
import 'package:e_presence/core/model/model_user.dart';
import 'package:e_presence/core/providers/api_controller.dart';
import 'package:e_presence/core/providers/user_controller.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AkunPage extends StatefulWidget {
  AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final styleThemeData = StyleThemeData();
  late ModelUser modelUser;
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() {
    final user = Provider.of<UserControlProvider>(context, listen: false);
    var val = "";
    user.loadProfile().then((value) {
      print(value);
      val = value.foto;
    });
    print(val);
    setState(() {});
    // print(modelUser.foto);
  }

  @override
  Widget build(BuildContext context) {
    // print(modelUser.foto);
    return SafeArea(
      child: LayoutBuilder(builder: (context, maxHeight) {
        return Consumer<UserControlProvider>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.54, right: 25),
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
                              width: 61,
                              height: 61,
                              decoration: BoxDecoration(
                                border: Border.all(width: 3),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Consumer<UserControlProvider>(
                                builder: (context, value, child) =>
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/viewPhoto");
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: value.source == null
                                        ? value.dataUser.foto == ""
                                            ? const Image(
                                                image: AssetImage(
                                                    "assets/image/profil_default.png"),
                                                fit: BoxFit.cover,
                                              )
                                            : Image(
                                                image: NetworkImage(
                                                  value.dataUser.foto,
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                        : Image.file(
                                            value.path,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 22.96,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.dataUser.nama,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              Text(
                                "NIS ${value.dataUser.nis}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              Text(
                                value.dataUser.email,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ],
                          ),
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                    top: 19,
                    left: 19,
                    right: 19,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pengaturan Akun",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/icons/ubh_sandi.png",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
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
                          title: Text(
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
                              Duration(seconds: 2),
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
          ),
        );
      }),
    );
  }
}
