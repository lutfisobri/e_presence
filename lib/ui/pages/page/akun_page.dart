import 'dart:async';

import 'package:e_presence/core/providers/api_controller.dart';
import 'package:e_presence/core/providers/user_controller.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AkunPage extends StatefulWidget {
  AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final styleThemeData = StyleThemeData();
  @override
  void initState() {
    super.initState();
    loadApi();
  }

  void loadApi() {
    final api = Provider.of<ApiController>(context, listen: false);
    api.loadJadwal();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, maxHeight) {
        return Consumer<UserControlProvider>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 25.r, left: 20.54.r, right: 25.r),
                height: 113,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: value.dataUser.photo == "" ? null: NetworkImage(value.dataUser.photo),
                        maxRadius: 37,
                        child: value.dataUser.photo == ""
                            ? Image.asset("assets/image/profil_default.png")
                            : null,
                      ),
                    ),
                    Positioned(
                      left: 82.r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.dataUser.username == ""
                                ? "loading"
                                : value.dataUser.username,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            value.dataUser.nis == ""
                                ? "loading"
                                : value.dataUser.nis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            value.dataUser.email == ""
                                ? "loading"
                                : value.dataUser.email,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 17.47.r,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/editProfile"),
                            child: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 13.74.r,
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                    top: 19.r,
                    left: 19.r,
                    right: 19.r,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pengaturan Akun",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 19.r,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.edit,
                          size: 18.sp,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Ubah Kata Sandi",
                          style: TextStyle(
                            fontSize: 12.6.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () =>
                            Navigator.pushNamed(context, "/ubahPassword"),
                      ),
                      const Divider(),
                      Consumer<UserControlProvider>(
                          builder: (context, value, child) {
                        return ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.black,
                            size: 18.sp,
                          ),
                          title: Text(
                            "Keluar",
                            style: TextStyle(
                              fontSize: 12.6.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "/login");
                            Timer(
                              Duration(seconds: 2),
                              () {
                                value.userLogout();
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
