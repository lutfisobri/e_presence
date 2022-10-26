import 'dart:async';
import 'package:e_presence/core/providers/user_controller.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  static const routeName = "/editProfile";
  final styleThemeData = StyleThemeData();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserControlProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Timer(Duration(seconds: 1), () {
          user.reset();
        });
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        photoProfile(),
                        SizedBox(
                          height: 28.28.r,
                        ),
                        Text(
                          "Nama Lengkap *",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        Consumer<UserControlProvider>(
                            builder: (context, value, child) {
                          return WidgetTextField(
                            initialValue: value.dataUser.username,
                            contenH: 0,
                            enable: false,
                            style: TextStyle(
                              color: const Color(0XFF858585),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            disableBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.5,
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 18.5.r,
                        ),
                        Text(
                          "E-mail *",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        Consumer<UserControlProvider>(
                            builder: (context, value, child) {
                          emailController.text = value.dataUser.email;
                          return WidgetTextField(
                            controller: emailController,
                            // initialValue: value.dataUser.email,
                            contenH: 0,
                            primaryColor: Colors.black,
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Nisn *",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        Consumer<UserControlProvider>(
                          builder: (context, value, child) {
                            return WidgetTextField(
                              initialValue: value.dataUser.username,
                              contenH: 0,
                              style: TextStyle(
                                color: const Color(0XFF858585),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              enable: false,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Tanggal Lahir *",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        WidgetTextField(
                          onTap: () {},
                          initialValue: "Abcde",
                          primaryColor: Colors.black,
                          readOnly: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          sufixIcon1: const Icon(Icons.calendar_month),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Kelas *",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        Consumer<UserControlProvider>(
                            builder: (context, value, child) {
                          return WidgetTextField(
                            enable: false,
                            initialValue: value.dataUser.kelas,
                            style: TextStyle(
                              color: const Color(0XFF858585),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Consumer<UserControlProvider>(
                                builder: (context, value, child) {
                              return WidgetEleBtn(
                                onPres: () {
                                  var photo = value.source?.path;
                                  value.updateProfile(
                                    emailController.text,
                                    photo,
                                  );
                                  // modalBottomSheet(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.77.r),
                                ),
                                textStyle: TextStyle(fontSize: 14.sp),
                                child: Text("Simpan"),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 60.45.r,
                    left: 196.2.r,
                    right: 131.4.r,
                    child: Container(
                      height: 30.6.h,
                      width: 30.6.w,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Consumer<UserControlProvider>(
                          builder: (context, user, child) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            user.reset();
                            user.pickImage();
                            // updatePhoto(context);
                          },
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> updatePhoto(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 174,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 25),
                child: Text(
                  "Foto Profil",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset(
                              "assets/icons/kamera.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 23, top: 10),
                          child: Text(
                            "Kamera",
                            style: TextStyle(
                              color: Color(0XFF646161),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Image.asset(
                            "assets/icons/galeri.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 34, top: 10),
                          child: Text(
                            "Galeri",
                            style: TextStyle(
                              color: Color(0XFF646161),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Image.asset(
                            "assets/icons/hapus.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 34, top: 10),
                          child: Text(
                            "Hapus",
                            style: TextStyle(
                              color: Color(0XFF646161),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Center photoProfile() {
    return Center(
      child: SizedBox(
        width: 90.r,
        height: 90.r,
        child: Consumer<UserControlProvider>(
          builder: (context, value, child) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/viewPhoto");
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: value.source == null
                  ? value.dataUser.foto == ""
                      ? const Image(
                          image: AssetImage("assets/image/profil_default.png"),
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
    );
  }

  Future<dynamic> modalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      enableDrag: false,
      backgroundColor: const Color(0XFFFAFAFA),
      context: context,
      builder: (context) => SizedBox(
        height: 428.h,
        width: double.infinity,
        child: Column(
          children: [
            GestureDetector(
              child: const SizedBox(
                height: 11,
                width: 62,
                child: Divider(
                  thickness: 4,
                ),
              ),
            ),
            const SizedBox(
              height: 28.7,
            ),
            Image.asset(
              width: 240,
              height: 234.86,
              "assets/image/no_internet1.png",
            ),
            const SizedBox(
              height: 10.14,
            ),
            const Text(
              "Tidak Ada Koneksi Internet",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Mohon Periksa Lagi Kembali Koneksi Internet Anda.",
              maxLines: 2,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 19, right: 19),
                    child: WidgetEleBtn(
                      onPres: () {
                        Navigator.pop(context);
                      },
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                      child: const Text("OK"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
