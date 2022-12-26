import 'package:app_presensi/resources/utils/skeleton.dart';
import 'package:flutter/material.dart';

class SkeletonPresensi extends StatelessWidget {
  const SkeletonPresensi({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 19,
            right: 221.53,
            // top: 31.9,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 16,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 201,
            right: 19,
            // top: 27.9,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 21,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        //list
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 19,
            right: 291,
            top: 58.9,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 16,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 131,
            right: 19,
            top: 57.9,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 21,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        //list
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 19,
            right: 291,
            top: 107.9,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 16,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 131,
            right: 19,
            top: 107.9,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 21,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        //list
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 19,
            right: 291,
            top: 158.9,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 16,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 131,
            right: 19,
            top: 154.9,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 21,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        //list
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            left: 9,
            right: 9,
            top: 219.9,
          ),
          decoration: const BoxDecoration(),
          child: SkeletonContainer.square(
            height: 38,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }
}
