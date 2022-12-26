import 'dart:async';
import 'dart:io';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/presensi.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/app/services/image.dart';
import 'package:app_presensi/app/services/location.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/camera.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/views/pages/component/presensi/loading.dart';
import 'package:app_presensi/views/pages/component/presensi/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

class DetailPresensi extends StatefulWidget {
  const DetailPresensi({super.key});
  static const routeName = "/detailPresensi";

  @override
  State<DetailPresensi> createState() => _PresensiState();
}

class ListModelPresensi {
  final String data;
  ListModelPresensi(
    this.data,
  );
}

class _PresensiState extends State<DetailPresensi> {
  late StreamSubscription<InternetConnectionStatus> listener;
  bool isOnline = false;

  void hasConnect() async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            if (!mounted) return;
            checkAccount();
            if (!mounted) return;
            setState(() {
              isOnline = true;
              isSkeleton = false;
            });
            break;
          case InternetConnectionStatus.disconnected:
            if (!mounted) return;
            setState(() {
              isOnline = false;
              isSkeleton = true;
            });
            break;
        }
      },
    );
  }

  void init() async {
    bool check = await InternetConnectionChecker().hasConnection;
    if (!mounted) return;
    setState(() {
      isOnline = check;
    });
    if (isOnline) {
      _chose = items[0];
      checkAccount();
      isSkeleton = true;
    } else {}
  }

  ListModelPresensi? _chose;

  List<ListModelPresensi> items = [
    ListModelPresensi("Hadir"),
    ListModelPresensi("Izin"),
    ListModelPresensi("Sakit"),
  ];

  @override
  void initState() {
    super.initState();
    location();
    init();
    hasConnect();
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        isSkeleton = false;
      });
    });
  }

  checkAccount() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    bool isLogin = await user.checkAccount().then((value) => value);
    if (!isLogin) {
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
            },
          ),
        ),
      );
    }
  }

  location() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return showDialog(
        context: context,
        builder: (context) => const CustomDialog(
            title: "LOKASI",
            subtitle: "Mohon aktifkan lokasi",
            image: "assets/icons/gagal.png"),
      );
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {}

    if (permission == LocationPermission.deniedForever) {}
    Geolocator.getPositionStream().listen((Position position) async {
      distance = Geolocator.distanceBetween(
        -8.124655,
        113.336256,
        position.latitude,
        position.longitude,
      );
      lat = position.latitude;
      long = position.longitude;
    });
    setState(() {});
  }

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

  double? distance, lat, long;

  bool isLoading = false, isPresent = false, isSkeleton = true;

  File? image;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return WillPopScope(
      onWillPop: () async {
        subscription.cancel();
        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
              title: const Text("Presensi"),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              child: isSkeleton
                  ? SkeletonPresensi()
                  : Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Consumer<PelajaranProvider>(
                          builder: (context, pelProv, child) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Mata Pelajaran",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  pelProv
                                      .findPresensi(id: args.toString())
                                      .namaMapel!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Mulai",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  DateFormat("dd MMMM y - hh.mm", "id_ID")
                                      .format(
                                    DateTime.parse(
                                      pelProv
                                          .findPresensi(id: args.toString())
                                          .mulaiPresensi!,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Selesai",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  DateFormat("dd MMMM y - hh.mm", "id_ID")
                                      .format(
                                    DateTime.parse(
                                      pelProv
                                          .findPresensi(id: args.toString())
                                          .akhirPresensi!,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Pengampu",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  pelProv
                                      .findPresensi(id: args.toString())
                                      .guru!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colorGreen,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: DropdownButton(
                                value: _chose,
                                items: items
                                    .map<DropdownMenuItem<ListModelPresensi>>(
                                  (e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              e.data,
                                              style: const TextStyle(
                                                color: colorGreen,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  if (value!.data != "Hadir") {
                                    setState(() {
                                      isPresent = true;
                                    });
                                  } else {
                                    setState(() {
                                      isPresent = false;
                                    });
                                  }
                                  setState(() {
                                    _chose = value;
                                  });
                                },
                                underline: Container(),
                                isExpanded: true,
                                icon: Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: const Icon(
                                    Icons.arrow_drop_down,
                                    color: colorGreen,
                                  ),
                                ),
                              ),
                            ),
                            (isPresent)
                                ? Consumer<UserProvider>(
                                    builder: (context, user, child) =>
                                        Container(
                                      margin: const EdgeInsets.only(
                                          top: 17, bottom: 13),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: colorGreen),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(11),
                                        onTap: () {
                                          serviceCamera(
                                            context,
                                            type: "Bukti Foto",
                                            kamera: () {
                                              takePhoto().then(
                                                (value) {
                                                  if (value != null) {
                                                    _cropImage(imageFile: value)
                                                        .then((value) {
                                                      if (value != null) {
                                                        setState(() {
                                                          image = value;
                                                        });
                                                      }
                                                    });
                                                  }
                                                },
                                              );
                                              Navigator.pop(context);
                                            },
                                            galeri: () {
                                              pickImage().then(
                                                (value) {
                                                  if (value != null) {
                                                    _cropImage(imageFile: value)
                                                        .then((value) {
                                                      if (value != null) {
                                                        setState(() {
                                                          image = value;
                                                        });
                                                      }
                                                    });
                                                  }
                                                },
                                              );
                                              Navigator.pop(context);
                                            },
                                            hapus: () {
                                              setState(() {
                                                image = null;
                                              });
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                        child: image == null
                                            ? SizedBox(
                                                height: 200,
                                                width: double.infinity,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 30),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/image/imagePresensi.png",
                                                        width: 70,
                                                        height: 70,
                                                      ),
                                                      const Text(
                                                        "Ambil bukti foto",
                                                        style: TextStyle(
                                                          color: colorGreen,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      if (_chose!.data ==
                                                          "Sakit")
                                                        const Text(
                                                          "*bukti berbentuk surat dokter",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: colorGreen,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 200,
                                                width: double.infinity,
                                                child: Image.file(
                                                  image!,
                                                  // scale: 5,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 17,
                                  ),
                            SizedBox(
                              width: double.infinity,
                              child: Button(
                                onPres: () {
                                  action(args.toString());
                                  if (!isOnline) {
                                    isSkeleton = true;
                                    isLoading = false;
                                  } else if (isOnline) {
                                    isSkeleton = false;
                                    isLoading = true;
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Roboto",
                                ),
                                child: const Text("SIMPAN"),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
            ),
          ),
          if (isLoading) PresensiLoading(),
        ],
      ),
    );
  }

  void action(String args) async {
    setState(() {
      isLoading = true;
    });
    if (!isOnline) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final pelProv = Provider.of<PelajaranProvider>(context, listen: false);
    final userProv = Provider.of<UserProvider>(context, listen: false);
    final presensi = Provider.of<PresensiProvider>(context, listen: false);
    validation();
    var date = await validationTime(
      DateTime.parse(pelProv.findPresensi(id: args).mulaiPresensi!),
      DateTime.parse(pelProv.findPresensi(id: args).akhirPresensi!),
    );
    if (!mounted) return;
    if (!date) {
      Navigator.pop(context);
      return;
    }
    final idPresensi = pelProv.findPresensi(id: args).idPresensi;
    final nis = userProv.dataUser.username;
    final time = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    final koordinat = "${lat!}, ${long!}";
    if (isPresent) {
      if (image == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      if (_chose!.data == "Sakit") {
        bool status = await presensi.presensiSakit(
          idPresensi: idPresensi!,
          nis: nis,
          time: time,
          koordinat: koordinat,
          bukti: image!.path,
        );
        if (status) {
          setState(() {
            isLoading = false;
          });
          if (!mounted) return;
          Navigator.pop(context);
          return;
        }
      }
      if (_chose!.data == "Izin") {
        bool status = await presensi.presensiIzin(
          idPresensi: idPresensi!,
          nis: nis,
          time: time,
          koordinat: koordinat,
          bukti: image!.path,
        );
        if (status) {
          setState(() {
            isLoading = false;
          });
          if (!mounted) return;
          Navigator.pop(context);
          return;
        }
      }
    }
    if (!isPresent) {
      bool status = await presensi.presensiHadir(
        idPresensi: idPresensi!,
        nis: nis,
        time: time,
        koordinat: koordinat,
      );
      if (status) {
        setState(() {
          isLoading = false;
        });
        if (!mounted) return;
        Navigator.pop(context);
        return;
      }
    }
    Timer(
      const Duration(seconds: 2),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  void checkImage() {
    if (image == null) {
      return;
    }
  }

  void validation() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    final pelProv = Provider.of<PelajaranProvider>(context, listen: false);
    pelProv.allPresensi(
        idKelasAjaran: user.dataUser.idKelasAjaran!,
        nis: user.dataUser.username);
  }

  Future<bool> validationTime(DateTime jamAwal, DateTime jamAkhir) async {
    final int offset = await NTP.getNtpOffset(
      localTime: DateTime.now(),
      lookUpAddress: "0.id.pool.ntp.org",
    );
    DateTime internetTime = DateTime.now().add(Duration(milliseconds: offset));
    if (internetTime.isBefore(jamAwal)) return false;
    if (internetTime.isAfter(jamAkhir)) return false;
    return true;
  }
}
