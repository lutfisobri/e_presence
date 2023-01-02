import 'dart:async';
import 'dart:io';
import 'package:app_presensi/app/models/user.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/app/services/image.dart';
import 'package:app_presensi/app/services/validation.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/camera.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/dialog_with_button.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/session.dart';
import 'package:app_presensi/resources/widgets/shared/text_fields.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:app_presensi/views/user/component/edit/skeleton.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  bool waiting = true;
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
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
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
              activeControlsWidgetColor: const Color.fromRGBO(104, 187, 97, 1),
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
      return null;
    }
  }

  loadProfile() async {
    var user = Provider.of<UserProvider>(context, listen: false);
    bool isLogin = await user.checkAccount().then((value) => value);
    if (isLogin) {
      setState(() {
        nama.text = user.dataUser.nama;
        emailController.text = user.dataUser.email ?? "";
        nis.text = user.dataUser.username;
        tglLahir.text = user.dataUser.tglLahir ?? "2000-01-01";
        kelas.text = user.dataUser.kelas ?? "";
        modelUser = user.dataUser;
        waiting = false;
      });
    } else {
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
    }
  }

  @override
  void initState() {
    super.initState();
    getConnectivity();
    loadProfile();
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

  File? foto;

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (usr.dataUser.email == null || usr.dataUser.email == "null") {
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
                      ? const SkeletonEditProfile()
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
                                  AutofillGroup(
                                    child: WtextField(
                                      controller: emailController,
                                      autofillHints: const [
                                        AutofillHints.email
                                      ],
                                      contenH: 0,
                                      primaryColor: Colors.black,
                                      style: const TextStyle(
                                        // color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                        initialEntryMode:
                                            DatePickerEntryMode.calendarOnly,
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
                                  const Text(
                                    "Umur : 14 - 19 Tahun",
                                    style: TextStyle(
                                      color: Color(0XFF858585),
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                    ),
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
                                      type: "Foto Profil",
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
    DateTime date = DateTime.parse(tglLahir.text);
    if (date.isAfter(
            DateTime.now().subtract(Duration(days: (365.25 * 14).round()))) ||
        date.isBefore(
            DateTime.now().subtract(Duration(days: (365.25 * 19).round())))) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: const CustomDialog(
            title: "Gagal Tersimpan",
            subtitle: "Umur Anda Tidak Sesuai",
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
      if (value == 0) {
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
          const Duration(milliseconds: 2000),
          () => Navigator.pop(context),
        );
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pop(context),
        );
      } else if (value == 1) {
        setState(() {
          isLoading = false;
        });
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: DialogEmailIsSame(
              onPress: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
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
