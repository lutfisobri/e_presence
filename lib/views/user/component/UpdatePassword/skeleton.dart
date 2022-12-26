import 'package:app_presensi/resources/utils/skeleton.dart';
import 'package:flutter/material.dart';

class SkeletonUpadatePassword extends StatelessWidget {
  const SkeletonUpadatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          //box1
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 198,
              top: 30,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 17,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 9,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 37,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          //box2
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 198,
              top: 27,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 17,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 9,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 37,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          //box3
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 122,
              top: 27,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 17,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 9,
            ),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 37,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
