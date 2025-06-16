import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.heigtt, this.width, this.layer = 1});

  final double? heigtt, width;
  final int layer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigtt,
      width: width,
      padding: const EdgeInsets.all(12), //AppDefaulst.pading /2
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04 * layer),
          borderRadius:
              const BorderRadius.all(Radius.circular(12)) //AppDefaults.radius
          ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.04),
          shape: BoxShape.circle),
    );
  }
}
