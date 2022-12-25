import 'package:app_presensi/resources/utils/skeleton.dart';
import 'package:flutter/material.dart';

class SekeletonMapel extends StatelessWidget {
  const SekeletonMapel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 132,
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
              left: 19,
              right: 19,
              top: 30,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 4,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 15,
              right: 298,
              top: 46,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 116,
              right: 224,
              top: 46,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 182,
              right: 154,
              top: 46,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 266,
              right: 76,
              top: 46,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 340,
              right: 1,
              top: 46,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          //list
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 93,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56.6,
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 293.4,
              left: 31.6,
              top: 103.8,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 199,
              left: 107,
              top: 104,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 138,
              left: 107,
              top: 124,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          //list
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 162.2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56.6,
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 293.4,
              left: 31.6,
              top: 174,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 199,
              left: 107,
              top: 174,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 138,
              left: 107,
              top: 193,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          //list
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 231.41,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56.6,
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 293.4,
              left: 31.6,
              top: 242,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 199,
              left: 107,
              top: 242,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 138,
              left: 107,
              top: 262,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          //list
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 300.61,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56.6,
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 293.4,
              left: 31.6,
              top: 312,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 199,
              left: 107,
              top: 312,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 138,
              left: 107,
              top: 331,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          // list
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 369.81,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56.6,
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 293.4,
              left: 31.6,
              top: 381,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 199,
              left: 107,
              top: 381,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 138,
              left: 107,
              top: 401,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          // list
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 439.01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56.6,
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 293.4,
              left: 31.6,
              top: 451,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 199,
              left: 107,
              top: 451,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 138,
              left: 107,
              top: 470,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          // list
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 508.22,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56.6,
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 293.4,
              left: 31.6,
              top: 519.02,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 199,
              left: 107,
              top: 519.02,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              right: 138,
              left: 107,
              top: 537.52,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 15,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      );
  }
}
