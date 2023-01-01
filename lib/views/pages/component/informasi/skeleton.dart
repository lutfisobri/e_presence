import 'package:app_presensi/resources/utils/skeleton.dart';
import 'package:flutter/material.dart';

class SkeletonInformasi extends StatelessWidget {
  const SkeletonInformasi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(
            height: 263,
            child: SkeletonContainer.square(
              height: 263,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
                left: 19, right: 230, top: 19),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 25,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin:
                const EdgeInsets.only(left: 19, right: 19, top: 10),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin:
                const EdgeInsets.only(left: 19, right: 19, top: 10),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
                left: 242, right: 19, top: 67),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 18,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
                left: 242, right: 19, top: 10),
            decoration: const BoxDecoration(),
            child: SkeletonContainer.square(
              height: 18,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      );
  }
}
