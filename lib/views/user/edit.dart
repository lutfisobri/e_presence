import 'dart:async';
import 'dart:io';
import 'package:app_presensi/app/models/user.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/app/services/image.dart';
import 'package:app_presensi/app/services/validation.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/camera.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/text_fields.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../pages/skeleton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static const routeName = "/editProfile";

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlert = false;
  final styleThemeData = StyleThemeData();
  TextEditingController nama = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nis = TextEditingController();
  TextEditingController tglLahir = TextEditingController();
  TextEditingController kelas = TextEditingController();
  ModelUser modelUser = ModelUser(
    username: "",
    nama: "",
    kelas: "",
    idKelas: "",
    tglLahir: "",
    foto: "",
    email: "",
    deviceId: "",
  );

  Future<File?> _cropImage({required File imageFile}) async {
    try {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        maxHeight: 1080,
        maxWidth: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Sunting Foto',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              backgroundColor: Colors.black,
              statusBarColor: Colors.white,
              dimmedLayerColor: Colors.black,
              cropFrameColor: Colors.white,
              cropGridColor: Colors.white,
              activeControlsWidgetColor: Color.fromRGBO(104, 187, 97, 1),
              showCropGrid: true,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Sunting Foto',
          ),
        ],
      );
      if (croppedImage != null) {
        return File(croppedImage.path);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  loadProfile() {
    var user = Provider.of<UserProvider>(context, listen: false);
    user.checkAccount().then((value) {
      if (!value) {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: DialogSession(
              onPress: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacementNamed(context, "/login");
                user.isLogin = false;
              },
            ),
          ),
        );
      } else {
        setState(() {
          nama.text = user.dataUser.nama;
          emailController.text = user.dataUser.email ?? "";
          nis.text = user.dataUser.username;
          tglLahir.text = user.dataUser.tglLahir ?? "";
          kelas.text = user.dataUser.kelas ?? "";
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getConnectivity();
    loadProfile();
    Future.delayed(
        const Duration(seconds: 1),
        () => setState(() {
              waiting = false;
            }));
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && !isAlert) {
            waiting = true;
            setState(() => isAlert = true);
          } else if (isDeviceConnected && isAlert) {
            waiting = false;
            setState(() => isAlert = false);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  bool isLoading = false;
  bool waiting = true;

  File? foto;

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (usr.isLogin) Navigator.pop(context);
        // usr.loadProfile();
        if (usr.dataUser.email == null) {
          return false;
        }

        if (usr.dataUser.email == "" && emailController.text != "") {
          return false;
        }

        if (usr.dataUser.tglLahir == "" && tglLahir.text != "") {
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
                  "Ubah Profil",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: waiting
                      ? Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 90.r,
                                height: 90.r,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: GestureDetector(
                                  child: Consumer<UserProvider>(
                                      builder: (context, value, child) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/image/profil_default.png"),
                                        width: 61,
                                        height: 61,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 209,
                                top: 114,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 21,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 18,
                                top: 157.5,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 276,
                                top: 201,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 21,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 18,
                                top: 244.5,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 248,
                                top: 288,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 21,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 18,
                                top: 331.5,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 225,
                                top: 375,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 21,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 18,
                                top: 418.5,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 285,
                                top: 462,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 21,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 18,
                                right: 18,
                                top: 500,
                              ),
                              decoration: const BoxDecoration(),
                              child: SkeletonContainer.square(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.only(
                            //     left: 235,
                            //     right: 18,
                            //     top: 531.5,
                            //     bottom: 60,
                            //   ),
                            //   child: Button(
                            //     onPres: () {},
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(7.77),
                            //     ),
                            //     minimunSize: const Size(109, 46),
                            //     textStyle: const TextStyle(
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.w600,
                            //       fontFamily: "Roboto",
                            //     ),
                            //     child: const Text("SIMPAN"),
                            //   ),
                            // ),
                          ],
                        )
                      : Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                                  WtextField(
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
                                  WtextField(
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
                                  WtextField(
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
                                  WtextField(
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime.parse(tglLahir.text),
                                        firstDate: DateTime(1990),
                                        lastDate: DateTime(2100),
                                        // initialEntryMode:
                                        //     DatePickerEntryMode.calendarOnly,
                                      ).then((value) {
                                        if (value != null &&
                                            value.isAfter(DateTime(1990))) {
                                          setState(() {
                                            tglLahir.text =
                                                DateFormat('y-MM-dd')
                                                    .format(value);
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
                                    sufixIcon1:
                                        const Icon(Icons.calendar_month),
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
                                  WtextField(
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
                                      Consumer<UserProvider>(
                                          builder: (context, value, child) {
                                        return Button(
                                          onPres: () {
                                            btnSave(value);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.77),
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
                                    serviceCamera(
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
                                              subtitle:
                                                  "Apakah anda ingin menghapus",
                                              btnLeft: "TIDAK",
                                              btnRight: "IYA",
                                              onPresLeft: () {
                                                Navigator.pop(context);
                                              },
                                              onPresRight: () {
                                                final delete =
                                                    Provider.of<UserProvider>(
                                                  context,
                                                  listen: false,
                                                );
                                                delete.deletePhoto(
                                                    modelUser.username);
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
                                              // setState(() {
                                              //   foto = value;
                                              // });
                                              _cropImage(imageFile: value)
                                                  .then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    foto = value;
                                                  });
                                                }
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
                                              // setState(() {
                                              //   foto = value;
                                              // });
                                              _cropImage(imageFile: value)
                                                  .then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    foto = value;
                                                  });
                                                }
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

  btnSave(UserProvider value) async {
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
        child: Consumer<UserProvider>(
          builder: (context, value, child) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/viewPhoto");
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: foto?.path == null
                  ? modelUser.foto == "" ||
                          modelUser.foto == null ||
                          modelUser.foto == "null"
                      ? const Image(
                          image: AssetImage("assets/image/profil_default.png"),
                          fit: BoxFit.cover,
                        )
                      : Image(
                          image: NetworkImage(
                            modelUser.foto!,
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
