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
import 'package:app_presensi/resources/widgets/shared/notifications/diluar_area.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/session.dart';
import 'package:app_presensi/views/pages/component/presensi/is_present.dart';
import 'package:app_presensi/views/pages/component/presensi/loading.dart';
import 'package:app_presensi/views/pages/component/presensi/mata_pelajaran.dart';
import 'package:app_presensi/views/pages/component/presensi/mulai_presensi.dart';
import 'package:app_presensi/views/pages/component/presensi/pengampu.dart';
import 'package:app_presensi/views/pages/component/presensi/selesai_presensi.dart';
import 'package:app_presensi/views/pages/component/presensi/skeleton.dart';
import 'package:app_presensi/views/pages/component/presensi/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailPresensi extends StatefulWidget {
  const DetailPresensi({super.key});
  static const routeName = "/detailPresensi";

  @override
  State<DetailPresensi> createState() => _PresensiState();
}

class _PresensiState extends State<DetailPresensi> {
  late StreamSubscription<InternetConnectionStatus> listener;

  final double _latitude = -8.124655;
  final double _longitude = 113.336256;

  double? distance, lat, long;

  bool isOnline = false,
      isLoading = false,
      isPresent = false,
      isSkeleton = true;

  File? image;

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

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  void close() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    final pelajaran = Provider.of<PelajaranProvider>(context, listen: false);
    pelajaran.allPresensi(
        idKelasAjaran: user.dataUser.idKelasAjaran!,
        nis: user.dataUser.username);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return WillPopScope(
      onWillPop: () async {
        subscription.cancel();
        close();
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
                  ? const SkeletonPresensi()
                  : Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          MataPelajaran(id: args.toString()),
                          h20(),
                          MulaiPresensi(id: args.toString()),
                          h20(),
                          SelesaiPresensi(id: args.toString()),
                          h20(),
                          Pengampu(id: args.toString()),
                          h20(),
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
                                updateListModelPresensi(value);
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
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 17, bottom: 13),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: colorGreen),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(11),
                                    onTap: () {
                                      camera();
                                    },
                                    child: image == null
                                        ? IsPresent(chose: _chose)
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
                                )
                              : const SizedBox(
                                  height: 17,
                                ),
                          SizedBox(
                            width: double.infinity,
                            child: Button(
                              onPres: () async {
                                UtilsPresensi.hasPermission();
                                hasLocation();
                                processPresensi(args.toString());
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
                      ),
                    ),
            ),
          ),
          if (isLoading) const PresensiLoading(),
        ],
      ),
    );
  }

  void updateListModelPresensi(value) {
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
  }

  void validate() async {
    bool check = await InternetConnectionChecker().hasConnection;
    if (!mounted) return;
    setState(() {
      isOnline = check;
    });
    if (!isOnline) {
      setState(() {
        isSkeleton = true;
        isLoading = false;
      });
      return;
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      UtilsPresensi.dialog(context);
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pop(context),
      );
      return;
    }
  }

  void presentImageNull() {
    setState(() {
      isLoading = false;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: CustomDialogPresensi(
            onTapbtn: () {
              Navigator.pop(context);
              isLoading = false;
            },
            childbtn: const Text(
              "KEMBALI",
            ),
          ),
        ),
      );
    });
    isLoading = false;
    return;
  }

  void notPresent(nis, time, koordinat, idPresensi) async {
    final pelProv = Provider.of<PelajaranProvider>(context, listen: false);
    final userProv = Provider.of<UserProvider>(context, listen: false);
    final presensi = Provider.of<PresensiProvider>(context, listen: false);
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
        pelProv.allPresensi(
            idKelasAjaran: userProv.dataUser.idKelasAjaran!,
            nis: userProv.dataUser.username);
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
        pelProv.allPresensi(
            idKelasAjaran: userProv.dataUser.idKelasAjaran!,
            nis: userProv.dataUser.username);
        Navigator.pop(context);
        return;
      }
    }
  }

  void processPresensi(String args) async {
    final pelProv = Provider.of<PelajaranProvider>(context, listen: false);
    final userProv = Provider.of<UserProvider>(context, listen: false);
    final presensi = Provider.of<PresensiProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    validate();
    if (!mounted) return;
    UtilsPresensi.validation(context);
    var date = await UtilsPresensi.validationTime(
      DateTime.parse(pelProv.findPresensi(id: args).mulaiPresensi!),
      DateTime.parse(pelProv.findPresensi(id: args).akhirPresensi!),
    );
    if (!mounted) return;
    if (!date) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Waktu Presensi Sudah Berakhir"),
        ),
      );
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      return;
    }
    final idPresensi = pelProv.findPresensi(id: args).idPresensi;
    final nis = userProv.dataUser.username;
    final time = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    if (lat == null || long == null) {
      getLocation();
      while (lat == null || long == null) {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    final koordinat = "${lat!},${long!}";
    if (isPresent) {
      if (image == null) {
        presentImageNull();
      } else if (image != null) {
        notPresent(nis, time, koordinat, idPresensi);
      }
    }
    if (!isPresent) {
      // validateDistance();
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
        Timer(const Duration(milliseconds: 800), () {
          pelProv.allPresensi(
            idKelasAjaran: userProv.dataUser.idKelasAjaran!,
            nis: userProv.dataUser.username,
          );
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Presensi Berhasil"),
          ),
        );
        Navigator.pop(context);
        return;
      } else {
        setState(() {
          isLoading = false;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Presensi Gagal"),
          ),
        );
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

  validateDistance() {
    if (distance!.round() > 100) {
      setState(() {
        isLoading = false;
      });
      return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: CustomDialogDiluarArea(
              childbtn: const Text("PERGI KE AREA"),
              onTapbtn: () {
                Navigator.pop(context);
              },
            ),
          );
        },
      );
    }
  }

  void getLocation() {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (value) {
        setState(() {
          lat = value.latitude;
          long = value.longitude;
        });
      },
    );
  }

  void camera() {
    serviceCamera(
      context,
      type: "Bukti Foto",
      kamera: () async {
        if (!isOnline) {
          setState(() {
            isSkeleton = true;
          });
          Navigator.of(context).pop();
          return;
        }
        var value = await takePhoto();
        if (!mounted) return;
        Navigator.pop(context);
        if (value != null) {
          UtilsPresensi.cropImage(imageFile: value).then((value) {
            if (value != null) {
              setState(() {
                image = value;
              });
            }
          });
        }
      },
      galeri: () async {
        if (!isOnline) {
          setState(() {
            isSkeleton = true;
          });
          Navigator.of(context).pop();
          return;
        }
        var value = await pickImage();
        if (!mounted) return;
        Navigator.pop(context);
        if (value != null) {
          UtilsPresensi.cropImage(imageFile: value).then((value) {
            if (value != null) {
              setState(() {
                image = value;
              });
            }
          });
        }
      },
      hapus: () {
        setState(() {
          image = null;
        });
        Navigator.pop(context);
      },
    );
  }

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
    UtilsPresensi.hasPermission();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {}

    if (permission == LocationPermission.deniedForever) {}
    Geolocator.getPositionStream().listen((Position position) async {
      distance = Geolocator.distanceBetween(
        _latitude,
        _longitude,
        position.latitude,
        position.longitude,
      );
      lat = position.latitude;
      long = position.longitude;
    });
    setState(() {});
  }

  void hasLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      distance = Geolocator.distanceBetween(
        _latitude,
        _longitude,
        position.latitude,
        position.longitude,
      );
      lat = position.latitude;
      long = position.longitude;
    });
    Geolocator.getPositionStream().listen((Position position) async {
      distance = Geolocator.distanceBetween(
        _latitude,
        _longitude,
        position.latitude,
        position.longitude,
      );
      lat = position.latitude;
      long = position.longitude;
    });
    setState(() {});
    if (lat == null || long == null) {
      if (!mounted) return;
      UtilsPresensi.dialog(context);
    }
  }
}
