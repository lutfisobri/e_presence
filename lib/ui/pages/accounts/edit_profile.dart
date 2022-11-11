import 'dart:async';
import 'dart:io';
import 'package:e_presence/core/model/model_user.dart';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/core/services/image_service.dart';
import 'package:e_presence/core/services/validation.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/ui/shared/widgets/bottom_shet.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/dialog.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
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
    user.checkAccount().then((value) {
      if (value == 401) {
        if (!mounted) return;
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, "/login");
        user.isLogin = false;
      } else if (value == 203) {
        return;
      } else {
        user.isLogin = false;
      }
    });
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

  bool isLoading = false;

  File? foto;

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserControlProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (usr.isLogin) Navigator.pop(context);
        usr.loadProfile();
        if (usr.dataUser.email == "") {
          return false;
        }
        if (usr.dataUser.email == "" && emailController.text != "") {
          return false;
        }

        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Scaffold(
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
                            const Text(
                              "Nama Lengkap",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF858585),
                              ),
                            ),
                            WidgetTextField(
                              controller: nama,
                              contenH: 0,
                              enable: false,
                              style: const TextStyle(
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
                            const SizedBox(
                              height: 10.5,
                            ),
                            Text(
                              emailController.text != ""
                                  ? "E-mail"
                                  : "E-mail *",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF858585),
                              ),
                            ),
                            WidgetTextField(
                              controller: emailController,
                              contenH: 0,
                              primaryColor: Colors.black,
                              style: const TextStyle(
                                // color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10.5,
                            ),
                            const Text(
                              "Nisn",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF858585),
                              ),
                            ),
                            WidgetTextField(
                              controller: nis,
                              contenH: 0,
                              style: const TextStyle(
                                color: Color(0XFF858585),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              enable: false,
                            ),
                            const SizedBox(
                              height: 10.5,
                            ),
                            Text(
                              tglLahir.text != ""
                                  ? "Tanggal Lahir"
                                  : "Tanggal Lahir *",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF858585),
                              ),
                            ),
                            WidgetTextField(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse(tglLahir.text),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(2100),
                                  // initialEntryMode:
                                  //     DatePickerEntryMode.calendarOnly,
                                ).then((value) {
                                  if (value != null &&
                                      value.isAfter(DateTime(1990))) {
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
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              sufixIcon1: const Icon(Icons.calendar_month),
                            ),
                            const SizedBox(
                              height: 10.5,
                            ),
                            const Text(
                              "Kelas",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF858585),
                              ),
                            ),
                            WidgetTextField(
                              enable: false,
                              controller: kelas,
                              style: const TextStyle(
                                color: Color(0XFF858585),
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
                                      btnSave(value);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.77),
                                    ),
                                    minimunSize: const Size(109, 46),
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Roboto",
                                    ),
                                    child: const Text("SIMPAN"),
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
                              updatePhoto(
                                context,
                                hapus: () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => WillPopScope(
                                      onWillPop: () async => false,
                                      child: DialogButton(
                                        title: "Hapus foto profil",
                                        subtitle: "Apakah anda ingin menghapus",
                                        btnLeft: "TIDAK",
                                        btnRight: "IYA",
                                        onPresLeft: () {
                                          Navigator.pop(context);
                                        },
                                        onPresRight: () {
                                          final delete =
                                              Provider.of<UserControlProvider>(
                                            context,
                                            listen: false,
                                          );
                                          delete.deletePhoto(modelUser.nis);
                                          loadProfile();
                                          setState(() {
                                            foto = null;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                galeri: () {
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
                                kamera: () {
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
                              );
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
            if (isLoading)
              Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/loading/sepeda.gif",
                      width: 100,
                      height: 100,
                    ),
                    // CircularProgressIndicator(),
                    const SizedBox(
                      height: 2.63,
                    ),
                    const Text(
                      "Tunggu Proses",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  btnSave(UserControlProvider value) async {
    setState(() {
      isLoading = true;
    });
    FocusManager.instance.primaryFocus!.unfocus();
    var mailValid = emailValidation(emailController.text);
    if (!mailValid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: const CustomDialog(
            title: "Gagal Tersimpan",
            subtitle: "Periksa Kembali Data Anda",
            image: "assets/icons/gagal.png",
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pop(context),
      );
      return;
    }
    value
        .updateProfile(
      emailController.text,
      foto?.path.toString(),
      tglLahir.text,
    )
        .then((value) {
      if (value) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: const CustomDialog(
              title: "Berhasil",
              subtitle: "Woah, Profil anda berhasil diubah",
              image: "assets/icons/sukses.png",
            ),
          ),
        );
        loadProfile();
        Timer(
          const Duration(milliseconds: 1800),
          () => Navigator.pop(context),
        );
        Timer(
          const Duration(seconds: 3),
          () => Navigator.pop(context),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: const CustomDialog(
              title: "Gagal Tersimpan",
              subtitle: "Periksa Kembali Data Anda",
              image: "assets/icons/gagal.png",
            ),
          ),
        );
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pop(context),
        );
        setState(() {
          isLoading = false;
        });
        return;
      }
    });
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
