import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handheld_beta/core/components/skeleton.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;

  //this widget is used for displaying image networks a placeholder
  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = 12, // AppDfaults.radius
    this.borderRadius,
  });

  final String src;
  final double radius;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: src,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(fit: fit, image: imageProvider)),
        ),
        placeholder: (context, url) => const Skeleton(),
        errorWidget: (context, url, error) =>
            const Icon(Icons.add_ic_call_outlined),
      ),
    );
  }
}
