import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SkeletonEditProfile extends StatelessWidget {
  const SkeletonEditProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        ],
      );
  }
}
