import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/skeleton.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/dialog_with_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingAccount extends StatelessWidget {
  const LoadingAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      Stack(
                        children: [
                          Row(
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: GestureDetector(
                                    child: Consumer<UserProvider>(
                                        builder: (context, value, child) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: const Image(
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
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                              left: 90,
                              right: 160,
                              top: 30,
                              bottom: 68,
                            ),
                            decoration: const BoxDecoration(),
                            child: SkeletonContainer.square(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 90, right: 100, top: 53, bottom: 48),
                            decoration: const BoxDecoration(),
                            child: SkeletonContainer.square(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 90, right: 30, top: 73, bottom: 28),
                            decoration: const BoxDecoration(),
                            child: SkeletonContainer.square(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Positioned(
                            right: 1.5,
                            top: 25,
                            child: Image.asset(
                              "assets/icons/edit_profile.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 1.5,
                        top: 25,
                        child: InkWell(
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
                          onTap: () =>
                              Navigator.pushNamed(context, "/ubahPassword"),
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
                                      subtitle: "Apakah Anda ingin keluar?",
                                      btnLeft: "TIDAK",
                                      btnRight: "IYA",
                                      onPresLeft: () {
                                        Navigator.pop(context);
                                      },
                                      onPresRight: () async {
                                        const snackBar = SnackBar(
                                          content: Text(
                                            'Terjadi kesalahan, silahkan coba lagi!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: colorGreen,
                                        );
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .removeCurrentSnackBar();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
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
    );
  }
}
