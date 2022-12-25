import 'dart:async';
import 'package:app_presensi/app/providers/informasi.dart';
import 'package:app_presensi/views/pages/component/informasi/skeleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class DetailInformasi extends StatefulWidget {
  const DetailInformasi({Key? key}) : super(key: key);

  @override
  _DetailInformasiState createState() => _DetailInformasiState();
}

class _DetailInformasiState extends State<DetailInformasi> {
  late StreamSubscription<InternetConnectionStatus> listener;
  bool isOnline = false;

  void hasConnect() async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            setState(() {
              isOnline = true;
            });
            break;
          case InternetConnectionStatus.disconnected:
            if (!mounted) return;
            setState(() {
              isOnline = false;
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
    } else {}
  }

  @override
  void initState() {
    super.initState();
    hasConnect();
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InformasiProvider>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            title: const Text("Detail Informasi"),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            child: isOnline
                ? SkeletonInformasi()
                : Column(
                    children: [
                      Container(
                        height: 263,
                        child: Consumer<InformasiProvider>(
                            builder: (context, value, child) {
                          return Center(
                            child: value.find(args).image == null
                                ? Image(
                                    image: AssetImage(
                                        'assets/image/icondefaultinformasi.png'),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: value.find(args).image!),
                          );
                        }),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                            const EdgeInsets.only(left: 19, right: 19, top: 10),
                        decoration: const BoxDecoration(),
                        child: Consumer<InformasiProvider>(
                            builder: (context, value, child) {
                          return Text(
                            value.find(args).judul ?? "",
                            style: TextStyle(
                              color: Color.fromRGBO(25, 61, 40, 1),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                            const EdgeInsets.only(left: 19, right: 19, top: 10),
                        decoration: const BoxDecoration(),
                        child: Consumer<InformasiProvider>(
                            builder: (context, value, child) {
                          return Text(
                            value.find(args).desc ?? "",
                            style: TextStyle(
                              color: Color.fromRGBO(25, 61, 40, 1),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 242, right: 19, top: 67),
                        decoration: const BoxDecoration(),
                        child: Consumer<InformasiProvider>(
                            builder: (context, value, child) {
                          return Text(
                            value.find(args).createdAt ?? "",
                            style: TextStyle(
                              color: Color.fromRGBO(25, 61, 40, 1),
                              fontSize: 13,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
          ),
        ),
        // if (isLoading)
        //   Column(
        //     children: const [
        //       Shimmer(),
        //       Shimmer(),
        //       Shimmer(),
        //     ],
        //   )

        // Container(
        //   alignment: Alignment.center,
        //   color: Colors.white.withOpacity(0.3),
        //   child: const Center(
        //     child: SizedBox(
        //       height: 75,
        //       width: 75,
        //       child: CircularProgressIndicator(
        //         strokeWidth: 2,
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
