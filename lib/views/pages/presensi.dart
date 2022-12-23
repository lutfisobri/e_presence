import 'dart:async';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/app/services/location.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  ListModelPresensi? _chose;

  List<ListModelPresensi> items = [
    ListModelPresensi("Hadir"),
    ListModelPresensi("Izin"),
    ListModelPresensi("Sakit"),
  ];

  @override
  void initState() {
    super.initState();
    _chose = items[0];
    location();
    checkAccount();
  }

  checkAccount() {
    final user = Provider.of<UserProvider>(context, listen: false);
    user.checkAccount().then((value) {
      if (value == 401) {
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
      } else if (value == 203) {
        return;
      } else {
        user.isLogin = false;
      }
    });
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
    });
    setState(() {});
  }

  double? distance;

  bool isLoading = false, notHadir = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    int index = int.parse(args.toString()) - 1;
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
              child: Container(
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
                            pelProv.listPresensi
                                .where((element) =>
                                    element.idPresensi == args.toString())
                                .first
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
                            DateFormat("dd MMMM y - hh.mm", "id_ID").format(
                              DateTime.parse(
                                pelProv.listPresensi
                                    .where((element) =>
                                        element.idPresensi == args.toString())
                                    .first
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
                            DateFormat("dd MMMM y - hh.mm", "id_ID").format(
                              DateTime.parse(
                                pelProv.listPresensi
                                    .where((element) =>
                                        element.idPresensi == args.toString())
                                    .first
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
                            pelProv.listPresensi
                                .where((element) =>
                                    element.idPresensi == args.toString())
                                .first
                                .namaMapel!,
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
                          items: items.map<DropdownMenuItem<ListModelPresensi>>(
                            (e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
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
                                notHadir = true;
                              });
                            } else {
                              setState(() {
                                notHadir = false;
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
                      (notHadir)
                          ? Consumer<UserProvider>(
                              builder: (context, user, child) => Container(
                                margin:
                                    const EdgeInsets.only(top: 17, bottom: 13),
                                decoration: BoxDecoration(
                                  border: Border.all(color: colorGreen),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                // child: InkWell(
                                //   borderRadius: BorderRadius.circular(11),
                                //   onTap: () {
                                //     // user.pickImage();
                                //   },
                                //   child: user.source == null
                                //       ? SizedBox(
                                //           height: 200,
                                //           width: double.infinity,
                                //           child: Padding(
                                //             padding: const EdgeInsets.only(
                                //                 top: 20, bottom: 30),
                                //             child: Column(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.center,
                                //               children: [
                                //                 Image.asset(
                                //                   "assets/image/imagePresensi.png",
                                //                   width: 70,
                                //                   height: 70,
                                //                 ),
                                //                 const Text(
                                //                   "Ambil bukti foto",
                                //                   style: TextStyle(
                                //                     color: colorGreen,
                                //                     fontSize: 18,
                                //                     fontWeight: FontWeight.w600,
                                //                   ),
                                //                 ),
                                //                 if (_chose!.data == "Sakit")
                                //                   const Text(
                                //                     "*bukti berbentuk surat dokter",
                                //                     style: TextStyle(
                                //                       fontSize: 12,
                                //                       fontWeight:
                                //                           FontWeight.w300,
                                //                       color: colorGreen,
                                //                     ),
                                //                   )
                                //               ],
                                //             ),
                                //           ),
                                //         )
                                //       : SizedBox(
                                //           height: 200,
                                //           width: double.infinity,
                                //           // child: Image.file(
                                //           //   user.source!,
                                //           //   // scale: 5,
                                //           //   fit: BoxFit.scaleDown,
                                //           // ),
                                //         ),
                                // ),
                              ),
                            )
                          : const SizedBox(
                              height: 17,
                            ),
                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          onPres: () {
                            setState(() {
                              isLoading = true;
                            });
                            var date = validationTime(
                              DateTime.parse(
                                pelProv.listPresensi[index].mulaiPresensi!,
                              ),
                              DateTime.parse(
                                pelProv.listPresensi[index].akhirPresensi!,
                              ),
                            );
                            Timer(
                              const Duration(seconds: 2),
                              () {
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            );
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
          if (isLoading)
            Container(
              alignment: Alignment.center,
              color: Colors.white.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/loading/pensil.gif",
                    width: 100,
                    height: 100,
                  ),
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
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<DateTime> validationTime(DateTime jamAwal, DateTime jamAkhir) async {
    final int offset = await NTP.getNtpOffset(
      localTime: DateTime.now(),
      lookUpAddress: "0.id.pool.ntp.org",
    );
    // DateTime internetTime =
    return DateTime.now().add(Duration(milliseconds: offset));
    // print(internetTime.isAfter(jamAkhir));
    // if (internetTime.isBefore(jamAwal)) return false;
    // if (internetTime.isAfter(jamAkhir)) return false;
  }
}
