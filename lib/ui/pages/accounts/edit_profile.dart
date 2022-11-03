import 'dart:async';
import 'dart:io';
import 'package:e_presence/core/model/model_user.dart';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/core/services/image_service.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});
  static const routeName = "/editProfile";

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final styleThemeData = StyleThemeData();
  TextEditingController nama = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nis = TextEditingController();
  TextEditingController tglLahir = TextEditingController();
  TextEditingController kelas = TextEditingController();
  ModelUser modelUser = ModelUser(
    username: "",
    password: "",
    email: "",
    foto: "",
    idKelas: "",
    nis: "",
    nama: "",
    kelamin: "",
    kelas: "",
    tglLahir: "",
    isLogin: "",
    deviceId: "",
  );

  loadProfile() {
    var user = Provider.of<UserControlProvider>(context, listen: false);
    user.loadProfile().then((value) {
      setState(() {
        modelUser = value;
        nama.text = value.nama;
        emailController.text = value.email;
        nis.text = value.nis;
        tglLahir.text = value.tglLahir;
        kelas.text = value.kelas;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  File? foto;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final usr = Provider.of<UserControlProvider>(context, listen: false);
        usr.loadProfile();
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
                          height: 14.28.r,
                        ),
                        Text(
                          "Nama Lengkap *",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        WidgetTextField(
                          controller: nama,
                          contenH: 0,
                          enable: false,
                          style: TextStyle(
                            color: Color(0XFF858585),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          disableBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.5,
                        ),
                        Text(
                          emailController.text != "" ? "E-mail" :
                          "E-mail *",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        WidgetTextField(
                          controller: emailController,
                          contenH: 0,
                          primaryColor: Colors.black,
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10.5,
                        ),
                        Text(
                          "Nisn *",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        WidgetTextField(
                          controller: nis,
                          contenH: 0,
                          style: TextStyle(
                            color: const Color(0XFF858585),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          enable: false,
                        ),
                        const SizedBox(
                          height: 10.5,
                        ),
                        Text(
                          tglLahir.text != "" ? 
                          "Tanggal Lahir" : "Tanggal Lahir *",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        WidgetTextField(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.parse(tglLahir.text),
                              firstDate: DateTime(1990),
                              lastDate: DateTime(2100),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  tglLahir.text =
                                      DateFormat('y-MM-dd').format(value);
                                });
                              }
                            });
                          },
                          controller: tglLahir,
                          primaryColor: Colors.black,
                          readOnly: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          sufixIcon1: const Icon(Icons.calendar_month),
                        ),
                        const SizedBox(
                          height: 10.5,
                        ),
                        Text(
                          "Kelas *",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF858585),
                          ),
                        ),
                        WidgetTextField(
                          enable: false,
                          controller: kelas,
                          style: TextStyle(
                            color: const Color(0XFF858585),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Consumer<UserControlProvider>(
                                builder: (context, value, child) {
                              return WidgetEleBtn(
                                onPres: () {
                                  value.updateProfile(
                                    emailController.text,
                                    foto?.path.toString(),
                                    tglLahir.text,
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.77),
                                ),
                                minimunSize: Size(109, 46),
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Roboto",
                                ),
                                child: Text("SIMPAN"),
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
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          updatePhoto(context);
                        },
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
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            takePhoto().then(
                              (value) {
                                if (value != null) {
                                  setState(() {
                                    foto = value;
                                  });
                                }
                              },
                            );
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/icons/kamera.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
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
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            pickImage().then(
                              (value) {
                                if (value != null) {
                                  setState(() {
                                    foto = value;
                                  });
                                }
                              },
                            );
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/icons/galeri.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
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
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            final delete = Provider.of<UserControlProvider>(
                              context,
                              listen: false,
                            );
                            delete.deletePhoto(modelUser.nis);
                            loadProfile();
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/icons/hapus.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
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
      child: Container(
        width: 90.r,
        height: 90.r,
        decoration: BoxDecoration(
          border: Border.all(width: 3),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Consumer<UserControlProvider>(
          builder: (context, value, child) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/viewPhoto");
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: foto?.path == null
                  ? modelUser.foto == ""
                      ? const Image(
                          image: AssetImage("assets/image/profil_default.png"),
                          fit: BoxFit.cover,
                        )
                      : Image(
                          image: NetworkImage(
                            modelUser.foto,
                          ),
                          fit: BoxFit.cover,
                        )
                  : Image.file(
                      foto!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
