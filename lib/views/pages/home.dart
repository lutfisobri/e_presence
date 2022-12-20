import 'dart:async';
import 'package:app_presensi/app/providers/informasi.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlert = false;

  loadPresensi() async {
    final loadPresen = Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    // loadPresen.loadPresensi(user.dataUser.idKelas);
    loadPresen.allPresensi(
        idKelas: user.dataUser.idKelas ?? "", nis: user.dataUser.username);
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

  @override
  void initState() {
    getConnectivity();
    super.initState();
    loadPresensi();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<InformasiProvider>(context, listen: false).getData();
    });
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && !isAlert) {
            showDialogbox();
            setState(() => isAlert = true);
          }
        },
      );
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogbox() => showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext contex) => CupertinoAlertDialog(
          title: const Text("Peringatan"),
          content: const Text("Tidak ada koneksi internet"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'cancel');
                setState(() => isAlert = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogbox();
                  setState(() => isAlert = true);
                }
              },
              child: const Text("Tutup"),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<PelajaranProvider>(
              builder: (context, value, child) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Mata Pelajaran",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "IBMPlex",
                          ),
                        ),
                        Text(
                          "Hari Ini",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: "Roboto"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12.6,
                  ),
                  value.listPresensi.isEmpty
                      ? nullContent(context)
                      : content(value),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.9, left: 19, right: 19, bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Informasi Akademik",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: "IBMPlex"),
                        ),
                        Text(
                          "Terbaru",
                          style: TextStyle(
                              fontSize: 12.6,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: "Roboto"),
                        ),
                      ],
                    ),
                  ),
                  inforAkademik(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox inforAkademik() {
    return SizedBox(
      height: 177,
      child: Consumer<InformasiProvider>(builder: (context, informasi, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => Container(
            width: 14,
          ),
          scrollDirection: Axis.horizontal,
          itemCount:
              informasi.informasi.length > 4 ? 4 : informasi.informasi.length,
          shrinkWrap: true,
          padding:
              const EdgeInsets.only(left: 19, right: 19, top: 8, bottom: 8),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/detailInformasi",
                  arguments: informasi.informasi[index].id);
            },
            child: Container(
              width: 246,
              height: 119,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0XFF909090).withOpacity(0.08),
                      offset: const Offset(1, 2),
                      blurRadius: 2,
                    ),
                    BoxShadow(
                      color: const Color(0XFF909090).withOpacity(0.20),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ]),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 12.6, right: 12.6, top: 4),
                      width: 246,
                      height: 90,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3.15),
                        child: informasi.informasi[index].image == null ||
                                informasi.informasi[index].image == ""
                            ? Image.asset(
                                "assets/image/icondefaultinformasi.png",
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: informasi.informasi[index].image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 12, right: 12, top: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            informasi.informasi[index].judul ?? "",
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF193D28),
                              overflow: TextOverflow.visible,
                              fontFamily: "Roboto",
                            ),
                          ),
                          Text(
                            informasi.informasi[index].createdAt ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF193D28),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Row nullContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
          child: Text(
            "Yeay, tidak ada mata pelajaran",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  Future<DateTime> validationTime() async {
    final int offset = await NTP.getNtpOffset(
      localTime: DateTime.now(),
      lookUpAddress: "0.id.pool.ntp.org",
    );
    return DateTime.now().add(Duration(milliseconds: offset));
  }

  ListView content(PelajaranProvider value) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 12.6,
      ),
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
      shrinkWrap: true,
      itemCount: value.listPresensi.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              "/detailPresensi",
              arguments: value.listPresensi[index].idPresensi,
            );
          },
          child: Container(
            height: 56.6,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0XFF909090).withOpacity(0.20),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 10.8, left: 12.6, bottom: 10.8),
                  height: 35,
                  width: 35,
                  child: iconMapel(value, index, jenis: Pelajaran.presensi),
                ),
                const SizedBox(
                  width: 12.6,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.listPresensi[index].namaMapel,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Roboto",
                      ),
                    ),
                    Text(
                      "Jam ${DateFormat('hh:mm', 'id_ID').format(
                        DateTime.parse(
                          value.listPresensi[index].jamAwal,
                        ),
                      )} - ${DateFormat('hh:mm', 'id_ID').format(
                        DateTime.parse(
                          value.listPresensi[index].jamAkhir,
                        ),
                      )} WIB",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
