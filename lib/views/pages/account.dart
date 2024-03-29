import 'dart:async';
import 'package:app_presensi/app/providers/informasi.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/dialog_with_button.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/session.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:app_presensi/views/pages/component/account/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  late StreamSubscription<InternetConnectionStatus> listener;
  bool isOnline = false;

  void hasConnect() async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            loadProfile();
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
    if (check) {
      loadProfile();
    } else {}
  }

  final styleThemeData = StyleThemeData();

  @override
  void initState() {
    super.initState();
    hasConnect();
    init();
    if (isOnline) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<InformasiProvider>(context, listen: false).getData();
      });
      loadProfile();
    }
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  loadProfile() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    bool isLogin = await user.checkAccount().then((value) => value);
    setState(() {
      isOnline = true;
    });
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

  @override
  Widget build(BuildContext context) {
    return isOnline
        ? Stack(
            children: [
              SafeArea(
                child: LayoutBuilder(builder: (context, maxHeight) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20.54, right: 25),
                        height: 113,
                        child: SizedBox(
                            // width: double.infinity,
                            child: Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 3),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/viewPhoto");
                                      },
                                      child: Consumer<UserProvider>(
                                          builder: (context, value, child) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: value.dataUser.foto == "" ||
                                                  value.dataUser.foto == "null"
                                              ? const Image(
                                                  image: AssetImage(
                                                      "assets/image/profil_default.png"),
                                                  width: 61,
                                                  height: 61,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image(
                                                  image: NetworkImage(
                                                    value.dataUser.foto!,
                                                  ),
                                                  width: 61,
                                                  height: 61,
                                                  fit: BoxFit.cover,
                                                ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 22.96,
                                ),
                                Consumer<UserProvider>(
                                    builder: (context, usrProv, child) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                          usrProv.dataUser.nama,
                                          overflow: TextOverflow.visible,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            overflow: TextOverflow.visible,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                          "NIS ${usrProv.dataUser.username}",
                                          overflow: TextOverflow.visible,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.visible,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                          usrProv.dataUser.email ?? "",
                                          overflow: TextOverflow.visible,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.visible,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                            Positioned(
                              right: 1.5,
                              top: 25,
                              child: InkWell(
                                onTap: () async {
                                  bool check = await InternetConnectionChecker()
                                      .hasConnection;
                                  if (!mounted) return;
                                  setState(() {
                                    isOnline = check;
                                  });
                                  if (isOnline) {
                                    Navigator.pushNamed(
                                        context, "/editProfile");
                                  } else {}
                                },
                                child: Image.asset(
                                  "assets/icons/edit_profile.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            )
                          ],
                        )),
                      ),
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: double.infinity,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(
                            top: 19,
                            left: 19,
                            right: 19,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Pengaturan Akun",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              const SizedBox(
                                height: 19,
                              ),
                              ListTile(
                                leading: Image.asset(
                                  "assets/icons/ubh_sandi.png",
                                  height: 30,
                                  width: 30,
                                ),
                                title: const Text(
                                  "Ubah Kata Sandi",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                onTap: () => Navigator.pushNamed(
                                    context, "/ubahPassword"),
                              ),
                              const Divider(),
                              Consumer<UserProvider>(
                                builder: (context, value, child) {
                                  return ListTile(
                                    leading: Image.asset(
                                      "assets/icons/keluar.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    title: const Text(
                                      "Keluar",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => WillPopScope(
                                          onWillPop: () async => false,
                                          child: DialogButton(
                                            title: "Keluar Dari E-Presensi",
                                            subtitle:
                                                "Apakah Anda ingin keluar?",
                                            btnLeft: "TIDAK",
                                            btnRight: "IYA",
                                            onPresLeft: () async {
                                              bool check =
                                                  await InternetConnectionChecker()
                                                      .hasConnection;
                                              if (!mounted) return;
                                              setState(() {
                                                isOnline = check;
                                              });
                                              if (isOnline) {
                                                Navigator.pop(context);
                                              } else {
                                                Navigator.pop(context);
                                                isOnline = false;
                                              }
                                            },
                                            onPresRight: () async {
                                              await value
                                                  .logout()
                                                  .then((status) {
                                                if (status) {
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, "/login");
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          )
        : const LoadingAccount();
  }
}
