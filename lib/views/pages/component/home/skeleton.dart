import 'package:app_presensi/resources/utils/skeleton.dart';
import 'package:flutter/material.dart';
//skeletonhome

class SkeletonHome extends StatelessWidget {
  const SkeletonHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 19,
            right: 128,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 19,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 282,
            right: 19,
            top: 5,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 14,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        //list
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 19,
            right: 19,
            top: 42,
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
            top: 53.4,
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
            top: 53.4,
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
            top: 74.4,
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
            top: 111.2,
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
            top: 121.4,
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
            top: 121.4,
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
            top: 144.4,
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
            top: 180.41,
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
            top: 191.21,
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
            top: 191.21,
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
            top: 213.4,
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
            left: 15,
            right: 146,
            top: 264,
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
            left: 288,
            right: 16,
            top: 265,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 16,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        //container
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 19,
            right: 135,
            top: 308,
          ),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.20),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 173,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            right: 145.6,
            top: 316.65,
            left: 28.6,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 94,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            right: 145.6,
            top: 416,
            left: 28.6,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 18,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            right: 250,
            top: 437,
            left: 28.6,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 15,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        //container
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 270,
            top: 308,
          ),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.20),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 173,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            top: 316.65,
            left: 280.6,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 94,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            top: 416,
            left: 280.6,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 18,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            top: 437,
            left: 280.6,
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
