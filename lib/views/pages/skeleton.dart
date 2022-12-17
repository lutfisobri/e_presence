import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonContainer._({
    this.width = double.infinity,
    this.height = double.infinity,
    Key? key,
  }) : super(key: key);

  const SkeletonContainer.square({
    required double height,
    required double width,
  }) : this._(width: width, height: height);

  @override
  Widget build(BuildContext context) => SkeletonAnimation(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
}
