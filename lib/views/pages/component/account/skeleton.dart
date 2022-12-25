import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/skeleton.dart';
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
          Row(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    borderRadius:
                        BorderRadius.circular(100),
                  ),
                  child: GestureDetector(
                    child: Consumer<UserProvider>(
                        builder: (context, value, child) {
                      return ClipRRect(
                        borderRadius:
                            BorderRadius.circular(100),
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
      );
  }
}
